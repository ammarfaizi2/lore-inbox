Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUADRir (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUADRir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:38:47 -0500
Received: from web8203.mail.in.yahoo.com ([203.199.70.117]:13682 "HELO
	web8203.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S265745AbUADRii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:38:38 -0500
Message-ID: <20040104173833.26140.qmail@web8203.mail.in.yahoo.com>
Date: Sun, 4 Jan 2004 17:38:33 +0000 (GMT)
From: =?iso-8859-1?q?Mr=20Amit=20Mehrotra?= <mehrotraamit@yahoo.co.in>
Subject: Re: PROBLEM: PCMCIA in 2.6.0 and 2.4.23 not detecting card inserts.
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040104153438.B22480@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

Thanks for the pointers. Grub seems to be putting this
automatically. I need to figure out a way to stop this
or switch to lilo (ugh)

Amit
 --- Russell King <rmk+lkml@arm.linux.org.uk> wrote: >
On Sun, Jan 04, 2004 at 02:37:55PM +0000, Mr Amit
> Mehrotra wrote:
> > Kernel command line: root=/dev/hda5 ro
> mem=1048512K
>                                         
> ^^^^^^^^^^^^
> 
> actually, I think this is your problem - you're
> overriding the E820
> memory map, and telling the kernel that anything
> above 1048512K is
> available for use.  Plainly this is not the case.
> 
> Please try booting without this argument.
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   -
> http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      -
> http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core 

________________________________________________________________________
Yahoo! India Mobile: Download the latest polyphonic ringtones.
Go to http://in.mobile.yahoo.com
