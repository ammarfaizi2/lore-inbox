Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVGYH32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVGYH32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVGYH32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 03:29:28 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:38550 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261655AbVGYH3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 03:29:24 -0400
Date: Mon, 25 Jul 2005 09:29:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Budde, Marco" <budde@telos.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stripping in module
In-Reply-To: <809C13DD6142E74ABE20C65B11A24398020882@www.telos.de>
Message-ID: <Pine.LNX.4.61.0507250928300.18209@yvahk01.tjqt.qr>
References: <809C13DD6142E74ABE20C65B11A24398020882@www.telos.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What is the best way to do this with v2.6.
>
>I have tried e.g. to remove all symbols starting with "telos"
>from the module like this (after kbuild):
>
>  strip -w -K '!telos*' -K 'telosi2c_usb_driver' telosi2c_linux.ko

Yes, I'd also be interested in what sections can actually be stripped, if any.
Userspace shared libs for example can be `strip -s`'ed and they still work as 
expected, does not look like this holds for kernel modules.



Jan Engelhardt
-- 
