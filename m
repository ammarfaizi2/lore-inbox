Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbUKOEv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUKOEv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbUKOEv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 23:51:59 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:25764 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261437AbUKOEv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 23:51:56 -0500
Subject: Re: [2.6 patch] SCSI: misc possible cleanups
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041115020432.GK2249@stusta.de>
References: <20041115020432.GK2249@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Nov 2004 22:50:46 -0600
Message-Id: <1100494253.24811.9.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-14 at 20:04, Adrian Bunk wrote:
> This patch below does:
> - remove unused code

Erm, some of the code you're trying to remove was recently added as
enablers for fibre channel drivers, like this:

[...]

>  drivers/scsi/scsi_transport_fc.c  |  202 ------------------------------

It's really not safe to remove code without understanding why it's there
in the first place.

James


