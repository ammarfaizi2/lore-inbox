Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVACIIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVACIIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 03:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVACIIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 03:08:34 -0500
Received: from news.suse.de ([195.135.220.2]:4317 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261356AbVACIId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 03:08:33 -0500
Date: Mon, 3 Jan 2005 09:08:32 +0100
From: Olaf Hering <olh@suse.de>
To: Christoph Anton Mitterer <cam@mathematica.scientia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with kernel bootparameters when using UDF fs support together with XFS quotas
Message-ID: <20050103080832.GA16355@suse.de>
References: <41D692E9.4060805@mathematica.scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41D692E9.4060805@mathematica.scientia.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 01, Christoph Anton Mitterer wrote:

> I'm using UDF filesystem support (CONFIG_UDF_FS) and quota support for
> XFS (CONFIG_XFS_QUOTA) in my kernel.
> Because I have to enable quota-controll on the root partition I append
> "rootflags=usrquota" to my kernel boot parameters.
> The XFS quota works fine now but it seems that the UDF driver has also
> an option called "rootflags":
> "udf: bad mount option "usrquota" or missing value"

rootfstype=xfs should fix it.
