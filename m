Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262487AbSI2Obf>; Sun, 29 Sep 2002 10:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262488AbSI2Obf>; Sun, 29 Sep 2002 10:31:35 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:49137 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262487AbSI2Obe>; Sun, 29 Sep 2002 10:31:34 -0400
Subject: Re: [PATCH] linux-2.5.39 - i8xx series chipsets patches (patch3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020929161148.A7376@medelec.uia.ac.be>
References: <20020929161148.A7376@medelec.uia.ac.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 15:42:38 +0100
Message-Id: <1033310558.13001.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 15:11, Wim Van Sebroeck wrote:
> Hi Linus,
> 
> this patch upgrades the i810-tco module to version 0.05. It fixes a possible timer_alive race,
> adds expect close support, cleans up ioctls, removes some unused stuff and adds support for
> the 82801DB and 82801E chipsets. patch2 (on pci_ids.h file) needs to be applied first.

This code is clearly incorrect. Please work off the current 2.4 driver
code because all the 2.5 watchdog code is obsolete and has security
holes. Worse still - you just added another one.


