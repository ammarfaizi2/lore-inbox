Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266185AbUGTUAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266185AbUGTUAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUGTT62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:58:28 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:54942 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266185AbUGTTyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:54:10 -0400
Subject: Re: [PATCH] depends on PCI DMA API: Adaptec AIC7xxx_old
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <200407201839.i6KIdo2I015550@anakin.of.borg>
References: <200407201839.i6KIdo2I015550@anakin.of.borg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Jul 2004 14:53:46 -0500
Message-Id: <1090353229.1947.7.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 13:39, Geert Uytterhoeven wrote:
> Adaptec AIC7xxx_old unconditionally depends on the PCI DMA API, so mark it
> broken if !PCI

Are you sure this is valid?  I thought it used a NULL pci device for
EISA (which I hate, but which still apparently works at least on x86).

James


