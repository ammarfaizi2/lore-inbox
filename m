Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUDZT3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUDZT3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUDZT3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:29:55 -0400
Received: from fmr05.intel.com ([134.134.136.6]:13195 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263389AbUDZT3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:29:53 -0400
Date: Mon, 26 Apr 2004 14:15:39 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200404262115.i3QLFdKE001551@snoqualmie.dp.intel.com>
To: akpm@osdl.org, Matt_Domsch@dell.com, metolent@snoqualmie.dp.intel.com
Subject: Re: [patch 1/3] efivars driver update and move
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Patch below fixes three small bugs in efivars.c as posted by Matt
>Tolentino last week and included in the latest -mm.  Aside from this
>small patch, I'm quite pleased with Matt T's work, thanks!=20
>
>* dummy() used for reading write-only sysfs files should return
>  -ENODEV to indicate failure, not 0.
>* efivar_create() should return the number of bytes written on
>  success, not zero. =20
>* efivar_delete() should return the number of bytes written on
>  success, not zero.
>
>Compiled, tested with efibootmgr-0.5.0-test3.  The anomolies I noted
>late Friday night are resolved by this kernel patch - efibootmgr was
>actually testing the values returned by writes.

Thanks for taking the time to look at this Matt...

matt

