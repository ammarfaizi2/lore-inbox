Return-Path: <linux-kernel-owner+w=401wt.eu-S1161067AbXAEMZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbXAEMZv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbXAEMZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:25:51 -0500
Received: from pat.uio.no ([129.240.10.15]:36664 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161067AbXAEMZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:25:50 -0500
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: Neil Brown <neilb@suse.de>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20070105024226.GA6076@mail.ustc.edu.cn>
References: <20070105024226.GA6076@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 13:25:39 +0100
Message-Id: <1167999939.6050.42.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 745DA992B569DB37F22F0C0C23029E0617350F93
X-UiO-SPAM-Test: 83.109.147.16 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-05 at 10:42 +0800, Fengguang Wu wrote:
> Hi Neil,
> 
> NFS mounting succeeded, but the kernel gives a warning.
> I'm running 2.6.20-rc2-mm1.
> 
> # mount -o vers=3 localhost:/suse /mnt
> [  689.651606] svc: unknown version (3)
> # mount | grep suse
> localhost:/suse on /mnt type nfs (rw,nfsvers=3,addr=127.0.0.1)

Are you perhaps running the userland NFS server instead of knfsd? The
former will only support NFSv2.

Trond

