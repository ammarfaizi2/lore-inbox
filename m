Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSKZGqx>; Tue, 26 Nov 2002 01:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSKZGqx>; Tue, 26 Nov 2002 01:46:53 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:5054 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266203AbSKZGqw>; Tue, 26 Nov 2002 01:46:52 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 25 Nov 2002 22:53:53 -0800
Message-Id: <200211260653.WAA22230@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Modules with list
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a little typo:

>        Why would setting skb->destructor attempt to increment the use
>count on a module?  As far as I can tell, it's own incremented in
                                                ^^^
>dev_open().

That should be "[...] it's *only* increment in dev_open()."

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
