Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTEUQbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 12:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTEUQbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 12:31:08 -0400
Received: from h-64-105-35-70.SNVACAID.covad.net ([64.105.35.70]:34945 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S262095AbTEUQbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 12:31:08 -0400
Date: Wed, 21 May 2003 09:44:07 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305211644.h4LGi7P21411@freya.yggdrasil.com>
To: zippel@linux-m68k.org
Subject: Re: 2.5.69-bk1[23] kconfig loop
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Roman Zippel wrote:
>On Mon, 19 May 2003, Adam J. Richter wrote:

>>         I expect there is no input that is supposed to cause
>> "make oldconfig" to go into an infinite loop, so this must at
>> least be a kconfig bug.

>Yes, it is, conf should not restart the configuration if the symbol isn't 
>changeable. The patch below fixes this and also fixes another possible 
>problem with menuconfig.
[...]

	Your patch fixed my problem.  Thanks!  I hope you will
send it or someting similar on its way to Linus.  If there is any
further testing you want me to do, please let me know.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
