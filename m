Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbSJFVmA>; Sun, 6 Oct 2002 17:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbSJFVl7>; Sun, 6 Oct 2002 17:41:59 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:10441 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262209AbSJFVl6>; Sun, 6 Oct 2002 17:41:58 -0400
Message-ID: <3DA0AFBE.935D25BA@bigpond.com>
Date: Mon, 07 Oct 2002 07:48:46 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 etc and IDE HDisk geometry
References: <3D9D9BE4.32421A87@bigpond.com> <20021004215049.GA20192@win.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> 
> On Fri, Oct 04, 2002 at 11:47:16PM +1000, Allan Duncan wrote:
> 
> > Question is - what is determining that initial value that becomes the "logical"
> > CHS, and does it matter?
> 
> No, it does not matter at all.
> CHS are meaningless numbers not used anywhere anymore in Linux.
> 
> If you want to influence what geometry *fdisk will use, give it
> the appropriate options or commands. No need to go via the kernel.
> But only in rare cases is it necessary to worry about geometry.

Like LILO.  It complains that the partition tables don't match the
geometry, or somesuch, despite an explicit "lba32".

Maybe I should start looking at grub, assuming it doesn't do the same.
