Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSBGNnK>; Thu, 7 Feb 2002 08:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSBGNnA>; Thu, 7 Feb 2002 08:43:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19844 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287647AbSBGNmm> convert rfc822-to-8bit; Thu, 7 Feb 2002 08:42:42 -0500
Date: Thu, 7 Feb 2002 08:44:21 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <3C61ACDB.6759302F@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1020207084153.4784A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Chris Friesen wrote:

> "Richard B. Johnson" wrote:
> 
> [snip]
> > Hackers code sendto as:
> >         sendto(s,...);
> > Professional programmers use:
> >         (void)sendto(s,...);
> > 
> > checking the return value is useless.
> > 
> > Note that the man-page specifically states that ENOBUFS can't happen.
> 
> I don't know what your manpage says, but my manpage doesn't say anything about
> ENOBUFS not being possible.  From the man page: 
> 
> "ENOBUFS The system was unable to allocate an internal memory block.  The
> operation may succeed when buffers become available."



       ENOBUFS
              The output queue for a network interface was  full.
              This  generally  indicates  that  the interface has
              stopped sending, but may  be  caused  by  transient
              congestion.   (This  cannot occur in Linux, packets
              are just silently dropped when a device queue over­
              flows.)


Linux Man Page              July 1999                           1

Script done on Thu Feb  7 08:35:39 2002

Distributed with RedHat 7




Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


