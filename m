Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318778AbSHBL0A>; Fri, 2 Aug 2002 07:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318779AbSHBL0A>; Fri, 2 Aug 2002 07:26:00 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:28943 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318778AbSHBLZ6>; Fri, 2 Aug 2002 07:25:58 -0400
Message-ID: <3D4A6D2B.2B1733D9@aitel.hist.no>
Date: Fri, 02 Aug 2002 13:29:47 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: Ivan Gyurdiev <ivangurdiev@attbi.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
References: <Pine.LNX.4.44.0208012302090.29483-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > The following trivial patches are still missing from the kernel:
> >
> >        - devfs patch to fix the problem with missing virtual consoles - only 0 in
> > /dev/vc: drivers/char/console.c
> 
> Try out my console patch at
> 
> http://www.transvirtual.com/~jsimmons/console.diff.gz
> 
> Please tell me if it solves the problem. I waiting for someone to say it
> works then I will push my BK stuff to Linus.

The patch works for me.  2.5.30 with this and the compile-fix for devfs
comes up with /dev/vc/ populated normally.

Helge Hafting
