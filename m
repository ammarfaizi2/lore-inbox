Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUI2Pf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUI2Pf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268592AbUI2Pfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 11:35:51 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:11959 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268527AbUI2Pfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 11:35:47 -0400
Subject: Re: [Patch] Fix oops on rmmod usb-storage
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Hannes Reinecke <hare@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040929152834.GH16153@parcelfarce.linux.theplanet.co.uk>
References: <415A67B8.2080003@suse.de> <1096466196.2028.8.camel@mulgrave>
	<1096463876.15905.23.camel@localhost.localdomain>
	<1096467874.1762.15.camel@mulgrave> <415ACA4C.807@suse.de>
	<1096470919.1762.21.camel@mulgrave> 
	<20040929152834.GH16153@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Sep 2004 11:35:29 -0400
Message-Id: <1096472135.2124.27.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 11:28, Matthew Wilcox wrote:
> How can this happen?  You're taking the address of dev->sdev_gendev, so it
> can't be NULL:

Just in case we link it into the device state model.

James


