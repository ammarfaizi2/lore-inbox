Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUCTB1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 20:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbUCTB1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 20:27:39 -0500
Received: from mail502.nifty.com ([202.248.37.210]:31471 "EHLO
	mail502.nifty.com") by vger.kernel.org with ESMTP id S263219AbUCTB1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 20:27:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Can I share several chroot'ed directories using 'mount --bind'?
From: Tetsuo Handa <a5497108@anet.ne.jp>
References: <200403192202.GEE75703.892856B1@anet.ne.jp>
In-Reply-To: <200403192202.GEE75703.892856B1@anet.ne.jp>
Message-Id: <200403201027.EAE41828.258196B8@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Sat, 20 Mar 2004 10:27:27 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Currently I need to use three partitions
> ( /data /jail/apache/data /jail/tomcat/data ).
> But I want to use only one partition, for
> adding new /jail/*/data requires fdisk,
> which is not acceptable.

I forgot to say one important thing.
The / directory is read only file system,
therefore I need to prepare writable partitions.

Regards...

                  Tetsuo Handa
