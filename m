Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbSLROKy>; Wed, 18 Dec 2002 09:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSLROKy>; Wed, 18 Dec 2002 09:10:54 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:41657 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267248AbSLROKx>; Wed, 18 Dec 2002 09:10:53 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 18 Dec 2002 06:18:14 -0800
Message-Id: <200212181418.GAA02729@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: 2.5.51 ide module problem
Cc: andre@linux-ide.org, axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I forgot to mention one thing in my the message that I sent
a minute ago: I understand that the cmd640_vlb kernel command line
argument needs to be settable via a module parameters for cmd640 to
be fully functional as a kernel module.  I will take care of that
if making cmd640 a module would work in the scenario that I described
(userland is careful not to set 32-bit IO or IRQ unmasking until the
cmd640 module can be loaded).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
