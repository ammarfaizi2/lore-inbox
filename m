Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbREHQ5c>; Tue, 8 May 2001 12:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132919AbREHQ5X>; Tue, 8 May 2001 12:57:23 -0400
Received: from eagle.verisign.com ([208.206.241.105]:50061 "EHLO
	eagle.verisign.com") by vger.kernel.org with ESMTP
	id <S132895AbREHQ5P>; Tue, 8 May 2001 12:57:15 -0400
From: slurn@verisign.com
Message-Id: <200105081657.JAA05739@slurndal-lnx.verisign.com>
Subject: Re: kdb wishlist
To: george@mvista.com (george anzinger)
Date: Tue, 8 May 2001 09:57:13 -0700 (PDT)
Cc: kaos@melbourne.sgi.com (Keith Owens), kdb@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3AF81720.A1E15AAE@mvista.com> from "george anzinger" at May 08, 2001 08:56:16 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Keith Owens wrote:
> > 
> > This is part of my kdb wishlist, does anybody fancy writing the code to
> > add any of these features?  It would be a nice project for anybody
> > wanting to start on the kernel.  Replies to kdb@oss.sgi.com please.
> > Current patches at http://oss.sgi.com/projects/kdb/download/
> > 
> > * Change kdb invocation key from ^A to ^X^X^X within 3 seconds.  ^A is
> >   used by emacs, bash, minicom etc.
> > 
> ^X^X swaps point and mark in emacs.  One (well, I) often will do
> ^X^X^X^X to examine where mark is and then return to point.

How about using the break condition instead.  This is only for the
serial port, and most terminal emulators (e.g. kermit, minicom) provide
a means to generate a break condition on the serial port. 

scott

> 
> George
> 
> ~snip
> 

