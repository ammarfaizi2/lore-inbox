Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVCZQAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVCZQAy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 11:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVCZQAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 11:00:53 -0500
Received: from quechua.inka.de ([193.197.184.2]:43997 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261154AbVCZQAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 11:00:50 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: INITRAMFS: junk in compressed archive
Date: Sat, 26 Mar 2005 17:06:21 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.03.26.16.06.20.883042@dungeon.inka.de>
References: <1111679972.5628.10.camel@FC3-bernhard-1.acousta.local> <1111762170.7238.3.camel@FC3-bernhard-1.acousta.local>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 14:51:07 +0000, Bernhard Schauer wrote:

> other question:
> 
> Is there any size-limit on initramfs image? I found out that after
> reducing the image size it is loaded & /init executed as expected...

compressed size plus uncompressed size have be less than the total
ram available.

maybe a few checks a remissing? I get a kernel panic.
it would be nice if the kernel dropped the initrd, and
then did the usual no root fs -> kernel panic code.

Andreas

