Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVCZKpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVCZKpt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVCZKps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:45:48 -0500
Received: from mail.dif.dk ([193.138.115.101]:41350 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262030AbVCZKoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:44:55 -0500
Date: Sat, 26 Mar 2005 11:46:49 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][trivial] fix tiny spelling error in init/Kconfig and
 write "so-called" instead of "so called" and "socalled" everywhere.
In-Reply-To: <4244D2BC.9000204@osdl.org>
Message-ID: <Pine.LNX.4.62.0503261130550.2437@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503260225170.2463@dragon.hyggekrogen.localhost>
 <4244D2BC.9000204@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, Randy.Dunlap wrote:

> Jesper Juhl wrote:
> > Fix spelling in init/Kconfig
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > 
> > --- linux-2.6.12-rc1-mm3-orig/init/Kconfig	2005-03-25 15:29:08.000000000
> > +0100
> > +++ linux-2.6.12-rc1-mm3/init/Kconfig	2005-03-26 02:24:33.000000000 +0100
> > @@ -83,7 +83,7 @@
> >  	default y
> >  	help
> >  	  This option allows you to choose whether you want to have support
> > -	  for socalled swap devices or swap files in your kernel that are
> > +	  for so called swap devices or swap files in your kernel that are
> >  	  used to provide more virtual memory than the actual RAM present
> >  	  in your computer.  If unsure say Y.
> 
> I would prefer (and write) "so-called".
> 
I believe both "so called" and "so-called" are valid, but "so-called" 
seems to be more common in the Kconfig files already. So let's be 
consistent about it.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/init/Kconfig	2005-03-25 15:29:08.000000000 +0100
+++ linux-2.6.12-rc1-mm3/init/Kconfig	2005-03-26 11:36:36.000000000 +0100
@@ -83,7 +83,7 @@ config SWAP
 	default y
 	help
 	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
+	  for so-called swap devices or swap files in your kernel that are
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
--- linux-2.6.12-rc1-mm3-orig/arch/cris/arch-v10/drivers/Kconfig	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc1-mm3/arch/cris/arch-v10/drivers/Kconfig	2005-03-26 11:35:56.000000000 +0100
@@ -836,7 +836,7 @@ config ETRAX_PA_BUTTON_BITMASK
 	help
 	  This is a bitmask with information about what bits on PA that
 	  are used for buttons.
-	  Most products has a so called TEST button on PA1, if that's true
+	  Most products has a so-called TEST button on PA1, if that's true
 	  use 02 here.
 	  Use 00 if there are no buttons on PA.
 	  If the bitmask is <> 00 a button driver will be included in the gpio
--- linux-2.6.12-rc1-mm3-orig/drivers/net/wireless/hostap/Kconfig	2005-03-25 15:28:57.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/net/wireless/hostap/Kconfig	2005-03-26 11:37:15.000000000 +0100
@@ -3,7 +3,7 @@ config HOSTAP
 	depends on NET_RADIO
 	---help---
 	Shared driver code for IEEE 802.11b wireless cards based on
-	Intersil Prism2/2.5/3 chipset. This driver supports so called
+	Intersil Prism2/2.5/3 chipset. This driver supports so-called
 	Host AP mode that allows the card to act as an IEEE 802.11
 	access point.
 
--- linux-2.6.12-rc1-mm3-orig/drivers/mtd/chips/Kconfig	2005-03-25 15:28:49.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/mtd/chips/Kconfig	2005-03-26 11:37:26.000000000 +0100
@@ -160,7 +160,7 @@ config MTD_OTP
 	depends on MTD_CFI_ADV_OPTIONS
 	default n
 	help
-	  This enables support for reading, writing and locking so called
+	  This enables support for reading, writing and locking so-called
 	  "Protection Registers" present on some flash chips.
 	  A subset of them are pre-programmed at the factory with a
 	  unique set of values. The rest is user-programmable.
--- linux-2.6.12-rc1-mm3-orig/drivers/media/dvb/ttpci/Kconfig	2005-03-25 15:28:49.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/media/dvb/ttpci/Kconfig	2005-03-26 11:38:16.000000000 +0100
@@ -68,7 +68,7 @@ config DVB_BUDGET
 	select DVB_TDA10021
 	help
 	  Support for simple SAA7146 based DVB cards
-	  (so called Budget- or Nova-PCI cards) without onboard
+	  (so-called Budget- or Nova-PCI cards) without onboard
 	  MPEG2 decoder.
 
 	  Say Y if you own such a card and want to use it.
@@ -84,7 +84,7 @@ config DVB_BUDGET_CI
 	select DVB_TDA1004X
 	help
 	  Support for simple SAA7146 based DVB cards
-	  (so called Budget- or Nova-PCI cards) without onboard
+	  (so-called Budget- or Nova-PCI cards) without onboard
 	  MPEG2 decoder, but with onboard Common Interface connector.
 
 	  Note: The Common Interface is not yet supported by this driver
@@ -103,7 +103,7 @@ config DVB_BUDGET_AV
 	select DVB_STV0299
 	help
 	  Support for simple SAA7146 based DVB cards
-	  (so called Budget- or Nova-PCI cards) without onboard
+	  (so-called Budget- or Nova-PCI cards) without onboard
 	  MPEG2 decoder, but with one or more analog video inputs.
 
 	  Say Y if you own such a card and want to use it.
--- linux-2.6.12-rc1-mm3-orig/drivers/crypto/Kconfig	2005-03-02 08:37:45.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/crypto/Kconfig	2005-03-26 11:38:24.000000000 +0100
@@ -5,7 +5,7 @@ config CRYPTO_DEV_PADLOCK
 	depends on CRYPTO && X86 && !X86_64
 	help
 	  Some VIA processors come with an integrated crypto engine
-	  (so called VIA PadLock ACE, Advanced Cryptography Engine)
+	  (so-called VIA PadLock ACE, Advanced Cryptography Engine)
 	  that provides instructions for very fast {en,de}cryption 
 	  with some algorithms.
 	  

