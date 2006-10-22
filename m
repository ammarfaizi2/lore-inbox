Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWJVQJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWJVQJU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWJVQJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:09:20 -0400
Received: from xenotime.net ([66.160.160.81]:3227 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751135AbWJVQJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:09:19 -0400
Date: Sun, 22 Oct 2006 09:10:54 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: petkov@math.uni-muenster.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] do not compile Sony Vaio extras as a module per default
Message-Id: <20061022091054.3fc8596b.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0610221254220.3696@yvahk01.tjqt.qr>
References: <20061022063924.GA7177@gollum.tnic>
	<Pine.LNX.4.61.0610221254220.3696@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006 12:54:30 +0200 (MEST) Jan Engelhardt wrote:

> 
> >--- current/drivers/acpi/Kconfig.orig	2006-10-21 10:02:23.000000000 +0200
> >+++ current/drivers/acpi/Kconfig	2006-10-21 10:02:30.000000000 +0200
> >@@ -262,7 +262,6 @@ config ACPI_SONY
> > 	tristate "Sony Laptop Extras"
> > 	depends on X86 && ACPI
> > 	select BACKLIGHT_CLASS_DEVICE
> >-	default m
> > 	  ---help---
> > 	  This mini-driver drives the ACPI SNC device present in the
> > 	  ACPI BIOS of the Sony Vaio laptops.
> 
> Reason?

This is the third such patch/request that I recall for this
one.  It's =m for Andrew (one of his machines).
Otherwise the patch makes sense and should be merged...

---
~Randy
