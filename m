Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316035AbSEJPVm>; Fri, 10 May 2002 11:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316032AbSEJPVl>; Fri, 10 May 2002 11:21:41 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:24716 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S316026AbSEJPU6>; Fri, 10 May 2002 11:20:58 -0400
Message-ID: <3CDBD9EA.1826BB48@nortelnetworks.com>
Date: Fri, 10 May 2002 10:32:10 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to redirect serial console to telnet session?
In-Reply-To: <3CDBC5A5.A1844CC0@nortelnetworks.com> <20020510160945.B7165@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, May 10, 2002 at 09:05:41AM -0400, Chris Friesen wrote:
> > Accordingly, I grabbed what looked like the important bits of xconsole, but it
> > appears that this only gets me stuff written to /dev/console from userspace.
> > How do I go about getting the output of kernel-level printk()s as well?
> 
> Check the LKML archives for something called 'netconsole' (or use google).
> It got mentioned here about 6 months to a year ago.

I found some patches by Ingo Molnar, but they look like kernel mods.

What I'm really looking for is a way to redirect this from userspace in a stock
kernel.  I want the serial console as normal, but then for just debugging this
one thing I want to telnet in over ethernet and basically redirect /dev/ttyS0
onto my telnet session.

Is this possible?

Chris 


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
