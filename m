Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTBLFLJ>; Wed, 12 Feb 2003 00:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbTBLFLJ>; Wed, 12 Feb 2003 00:11:09 -0500
Received: from web20408.mail.yahoo.com ([66.163.169.96]:64648 "HELO
	web20420.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261689AbTBLFLI>; Wed, 12 Feb 2003 00:11:08 -0500
Message-ID: <20030212052057.39704.qmail@web20420.mail.yahoo.com>
Date: Tue, 11 Feb 2003 21:20:56 -0800 (PST)
From: devnetfs <devnetfs@yahoo.com>
Subject: Re: compiling kernel with debug and optimization
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030210192324.GA154@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > Does compiling with -g option degrade performance? IMO it should
> > NOT.
> > If that's true, then why dont we compile kernels with both -g and
> > -O2 always? 
> 
> Build with -g takes *a lot* of diskspace, like 1Gig.
> 							Pavel

Agreed. But can't distro's give two SET's of RPMS:
   1. kernel-xyz.rpm
   2. kernel-xyz-debug.rpm

where both 1,2 are same kernels compiled w/ same config and with -g.
BUT rpm [1] is a 'strip -g' output of [2]. 

So people run [1] on their production systems. And developers analyze
core-dump from these systems using [2]. Can this be done and will it
work?

Thanks in advance,

Regards,
A.


ps: Please Cc: me the reply. I am not subscribed to the list.

__________________________________________________
Do you Yahoo!?
Yahoo! Shopping - Send Flowers for Valentine's Day
http://shopping.yahoo.com
