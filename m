Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264615AbTFKX3C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264620AbTFKX3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:29:02 -0400
Received: from h-64-105-35-118.SNVACAID.covad.net ([64.105.35.118]:15774 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S264615AbTFKX3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:29:00 -0400
Date: Wed, 11 Jun 2003 16:43:39 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200306112343.h5BNhdK13412@freya.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: 2.5.70-bk1[23]: load_module crashes when aborting module load
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003 at 11:39:45 +1000, Rusty Russell wrote:
>In message <200306091014.h59AEnU08591@adam.yggdrasil.com> you write:
[A report of a bug in kernel/module.c, which Rusty has already
submitted a patch for, followed by a mistaken second bug report on my part:] 
>> 	By the way, there also seems to be a bug in the
>> 2.5.70-bk12/kernel/module.c changes where mod->percpu is left unitialized
[...]

>Something is badly wrong: look in include/linux/module.h and you'll
>see the initialization of __this_module (which becomes mod).  By
>leaving the .percpu member uninitialized, it will be initialized to
>NULL.

You're right.  My misunderstanding was the result of flaky serial
console cable, which I've now replaced.  Sorry for the confusion.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
