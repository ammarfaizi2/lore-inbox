Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUAYKHh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 05:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUAYKHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 05:07:37 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:56585 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263898AbUAYKHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 05:07:36 -0500
Date: 25 Jan 2004 13:08:59 +0300
Message-Id: <87u12k5ohw.fsf@mtu-net.ru>
From: Serge Belyshev <33554432@mtu-net.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-reply-to: <20040124232914.13a2beb7.akpm@osdl.org> (message from Andrew
	Morton on Sat, 24 Jan 2004 23:29:14 -0800)
Subject: Re: [PATCH] add_*_randomness calls in usbkbd.c and usbmouse.c
References: <87vfn063fm.fsf@mtu-net.ru> <20040124232914.13a2beb7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   This function already calls input_report_key(), which calls
   add_mouse_randomness().  This change seems to be unneeded.

Ahhh, I forgot to do 'fgrep add_mouse_randomness -r /usr/src/linux'...
Sorry for inconvenience.
