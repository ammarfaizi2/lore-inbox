Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSGAPPB>; Mon, 1 Jul 2002 11:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSGAPPA>; Mon, 1 Jul 2002 11:15:00 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8116 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314551AbSGAPPA>; Mon, 1 Jul 2002 11:15:00 -0400
Date: Mon, 1 Jul 2002 11:16:49 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207011516.g61FGnP20648@devserv.devel.redhat.com>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
In-Reply-To: <mailman.1025521441.28343.linux-kernel2news@redhat.com>
References: <mailman.1025521441.28343.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My theory is that usbkbd.o doesn't cope with ErrorRollover which is
> being generated, unlike hid.o which didn't used to but does now.

I have an idea: remove usbkbd or make it extremely hard
for newbies to build (e.g. drop CONFIG_USB_KBD from config.in,
so it would need to be added manually if you want usbkbd).

At the very minimum I would like to see all distros, and
especially SuSE (because of Vojtech) to stop shipping usbkbd.o.

-- Pete
