Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTAJLIZ>; Fri, 10 Jan 2003 06:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTAJLIY>; Fri, 10 Jan 2003 06:08:24 -0500
Received: from h-64-105-35-49.SNVACAID.covad.net ([64.105.35.49]:15490 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264910AbTAJLIC>; Fri, 10 Jan 2003 06:08:02 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 10 Jan 2003 03:16:30 -0800
Message-Id: <200301101116.DAA03752@baldur.yggdrasil.com>
To: maxk@qualcomm.com
Subject: Re: Another idea for simplifying locking in kernel/module.c
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>On Thu, 09 Jan 2003, Max Krasnyansky wrote:
>>We have to be able to call try_module_get() from interrupt context.

>	Where?  Why?  Please show me one or more examples.

	Come to think of it, I don't think you even have to answer
that question.  You should be able to use my try_module_get() from
interrupt context.  It never blocks.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
