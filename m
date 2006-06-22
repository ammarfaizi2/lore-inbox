Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932822AbWFVH3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbWFVH3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbWFVH3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:29:15 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:32443 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932818AbWFVH3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:29:14 -0400
From: Duncan Sands <baldrick@free.fr>
To: juampe <juampe@iquis.com>
Subject: Re: [PATCH 06/13] USBATM: shutdown open connections when disconnected
Date: Thu, 22 Jun 2006 09:29:12 +0200
User-Agent: KMail/1.9.1
Cc: kernel <linux-kernel@vger.kernel.org>
References: <OF39174CF7.B508FCBD-ONC125718F.00407FFC-C125718F.00413F4F@telefonica.es> <44965CC3.1060203@iquis.com> <449660E1.30505@iquis.com>
In-Reply-To: <449660E1.30505@iquis.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606220929.13174.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juampe,

> I have problems with 2.6.17 and the speedtocuh driver block the
> conection at some point that  i can't locate.

I've just had a second report about problems with 2.6.17.
Two things to try:
(1) build your kernel with CONFIG_USB_DEBUG=y and check for
interesting messages in your system logs (dmesg).
(2) use bisection to try to work out exactly which change
to the kernel caused this problem to appear.  Check out
Documentation/BUG-HUNTING in the kernel source for an
description of how to do this.

Ciao,

Duncan.
