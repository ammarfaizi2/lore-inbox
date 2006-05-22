Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWEVENI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWEVENI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 00:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWEVENI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 00:13:08 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:46541 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S965005AbWEVENH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 00:13:07 -0400
Subject: RE: [LINUX-KERNEL] Problem loading any custom driver
From: Arjan van de Ven <arjan@infradead.org>
To: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1FB1F81B4767FC48A2AF2278D735CE64038BFC5E@cacexc05.americas.cpqcorp.net>
References: <1FB1F81B4767FC48A2AF2278D735CE64038BFC5E@cacexc05.americas.cpqcorp.net>
Content-Type: text/plain
Date: Mon, 22 May 2006 06:13:01 +0200
Message-Id: <1148271181.3902.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 21:05 -0700, Libershteyn, Vladimir wrote:
> Here is a makefile
> -------------------------------------------------
> #
> # Makefile for the Los Angeles PCI Adapter
> # This file supports Red Hat Linux kernel 2.6(included) and above
> #
> HPATH := /usr/src/kernels/2.6.9-34.EL-i686/include
> CFLAGS = -I$(HPATH) -Wall -O2 -fomit-frame-pointer -c
> CFLAGS := $(CFLAGS) -DHOST_LITTLE_ENDIAN -DHOST_SIZE_32
> 
> obj-m += atf_host.o

this is buggy, you have to drop the CFLAGS lines!!!!!


> Our group does not have ability to put files for outside access.
> Can you specify what parts of the code you need me to attach?
> Im not familiar with rules, is it allowed to attach source files?

yeah that's fine if they're not gigantic (50Kb or so is a reasonable
boundary for that)

