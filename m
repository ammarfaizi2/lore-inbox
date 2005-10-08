Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVJHPGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVJHPGe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 11:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVJHPGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 11:06:34 -0400
Received: from pantene.yandex.ru ([213.180.200.35]:50607 "EHLO
	pantene.yandex.ru") by vger.kernel.org with ESMTP id S932154AbVJHPGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 11:06:34 -0400
Date: Sat, 8 Oct 2005 19:06:17 +0400 (MSD)
From: "Ivan S. Dubrov" <WFrag@yandex.ru>
Message-Id: <4347E069.000001.31814@pantene.yandex.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ]
To: linux-kernel@vger.kernel.org
Subject: Problems with iPaq synchronization
Reply-To: WFrag@yandex.ru
X-Source-Ip: 217.117.80.2
Content-Type: text/plain;
  charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to synchronize with my iPaq (rx3715) and get the following error
(in dmesg):

usb 1-1: new full speed USB device using ohci_hcd and address 9
ipaq 1-1:2.0: PocketPC PDA converter detected
drivers/usb/serial/ipaq.c: active config #2 != 1 ??
ipaq: probe of 1-1:2.0 failed with error -5

I have kernel 2.6.12-1-amd64-k8 from the Debian/AMD64 Etch distribution.

P.S. I've read sources a bit and found that the USB active configuration
can be selected by the hotplug, but it is not clear how (and if it can solve
the problem).

WBR,
Ivan Dubrov.
