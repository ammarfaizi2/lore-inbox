Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317748AbSFSCvF>; Tue, 18 Jun 2002 22:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317749AbSFSCvE>; Tue, 18 Jun 2002 22:51:04 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:65169 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317748AbSFSCvD>; Tue, 18 Jun 2002 22:51:03 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 18 Jun 2002 19:50:55 -0700
Message-Id: <200206190250.TAA09390@adam.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Re: Various kbuild problems in 2.5.22
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski writes:

>Well, let's say I agree that the kind of semantics change regarding
>building modules at the same time isn't the nicest. So I propose the
>following:

>make bzImage -> compile built-in, build bzImage
>make modules -> compile modules
>make bzImage modules -> build bzImage + modules (I found a way to do so
>                        without having to descend twice)

>make,
>make all     -> compile vmlinux + modules as a general default,
>                on i386 build bzImage + modules.
>               (other archs can change the behavior as they wish)

        Great.  That's fine with me.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
