Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWJVK4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWJVK4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 06:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWJVK4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 06:56:13 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:39554 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932363AbWJVK4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 06:56:11 -0400
Date: Sun, 22 Oct 2006 12:54:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: petkov@math.uni-muenster.de
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] do not compile Sony Vaio extras as a module per default
In-Reply-To: <20061022063924.GA7177@gollum.tnic>
Message-ID: <Pine.LNX.4.61.0610221254220.3696@yvahk01.tjqt.qr>
References: <20061022063924.GA7177@gollum.tnic>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>--- current/drivers/acpi/Kconfig.orig	2006-10-21 10:02:23.000000000 +0200
>+++ current/drivers/acpi/Kconfig	2006-10-21 10:02:30.000000000 +0200
>@@ -262,7 +262,6 @@ config ACPI_SONY
> 	tristate "Sony Laptop Extras"
> 	depends on X86 && ACPI
> 	select BACKLIGHT_CLASS_DEVICE
>-	default m
> 	  ---help---
> 	  This mini-driver drives the ACPI SNC device present in the
> 	  ACPI BIOS of the Sony Vaio laptops.

Reason?


	-`J'
-- 
