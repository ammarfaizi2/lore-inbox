Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVCZXar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVCZXar (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 18:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVCZXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 18:30:46 -0500
Received: from hera.kernel.org ([209.128.68.125]:48541 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261339AbVCZXam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 18:30:42 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: INITRAMFS: junk in compressed archive
Date: Sat, 26 Mar 2005 23:30:21 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d24rad$378$1@terminus.zytor.com>
References: <1111679972.5628.10.camel@FC3-bernhard-1.acousta.local> <1111762170.7238.3.camel@FC3-bernhard-1.acousta.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1111879821 3305 127.0.0.1 (26 Mar 2005 23:30:21 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 26 Mar 2005 23:30:21 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1111762170.7238.3.camel@FC3-bernhard-1.acousta.local>
By author:    Bernhard Schauer <linux-kernel-list@acousta.at>
In newsgroup: linux.dev.kernel
>
> other question:
> 
> Is there any size-limit on initramfs image? I found out that after
> reducing the image size it is loaded & /init executed as expected...
> 

Kernel + compressed initramfs + uncompressed initramfs must fit in memory at
the same time.

	-hpa
