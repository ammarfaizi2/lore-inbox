Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbUKTWO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUKTWO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 17:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKTWO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 17:14:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27836 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261278AbUKTWO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 17:14:56 -0500
Date: Sat, 20 Nov 2004 23:14:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Zoltan Sutto <sutto.zoltan@rutinsoft.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28 module compile problem
In-Reply-To: <000301c4cf4c$0d771a70$6402a8c0@SUTIHOME>
Message-ID: <Pine.LNX.4.53.0411202313350.25253@yvahk01.tjqt.qr>
References: <000301c4cf4c$0d771a70$6402a8c0@SUTIHOME>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi!
>
>I got this error message compiling modules for kernel 2.4.28.

Add #include <linux/module.h> in dn_neigh.c, probably.

>dn_neigh.c:584: `THIS_MODULE' undeclared here (not in a function)
>dn_neigh.c:584: initializer element is not constant
>dn_neigh.c:584: (near initialization for `dn_neigh_seq_fops.owner')
>make[2]: *** [dn_neigh.o] Error 1
>make[2]: Leaving directory `/usr/src/linux-2.4.28/net/decnet'
>make[1]: *** [_modsubdir_decnet] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.4.28/net'
>make: *** [_mod_net] Error 2

Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
