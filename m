Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVKHQRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVKHQRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVKHQRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:17:41 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:57522 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932391AbVKHQRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:17:40 -0500
Subject: Re: PATCH: libata PATA patches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051108141340.GT3847@stusta.de>
References: <1131460386.25192.45.camel@localhost.localdomain>
	 <20051108141340.GT3847@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 16:46:24 +0000
Message-Id: <1131468384.25192.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-08 at 15:13 +0100, Adrian Bunk wrote:
> Shouldn't the following at the top of arch/i386/Makefile already do the 
> same?
> 
> HAS_BIARCH      := $(call cc-option-yn, -m32)
> ifeq ($(HAS_BIARCH),y)
> AS              := $(AS) --32
> LD              := $(LD) -m elf_i386
> CC              := $(CC) -m32
> endif
> 

Its just left overs from my old build patches I forgot to clean out.
Harmless however.

