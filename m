Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291170AbSBLUr5>; Tue, 12 Feb 2002 15:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291171AbSBLUrs>; Tue, 12 Feb 2002 15:47:48 -0500
Received: from nwhn-sh19-port93.snet.net ([204.60.209.93]:55168 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S291170AbSBLUrg>;
	Tue, 12 Feb 2002 15:47:36 -0500
Message-Id: <200202121549.g1CFnb004555@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: TUN/TAP driver doesn't work. 
In-Reply-To: Your message of "Sun, 10 Feb 2002 22:17:19 EST."
             <Pine.NEB.4.33.0202102204200.21611-100000@courage.cs.stevens-tech.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Feb 2002 10:49:37 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mzawadzk@cs.stevens-tech.edu said:
> Did they change values of #defines for TUN/TAP ioctls' numbers, or
> what? 

Yup, they sure did.

> If so, that's quite bad in my opinion (what if somebody had
> binary-only version of his client?).

Yup, it sure is.  It screwed UML over too.

BTW, if you (or anyone else) still needs to look at working TUN/TAP code,
UML has had a TUN/TAP network backend for a while.  See 
arch/um/drivers/tuntap*.

I've also got persistent TUN/TAP support mostly working in my private pool,
it will appear in a patch shortly.

				Jeff

