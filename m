Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270440AbRHHKEu>; Wed, 8 Aug 2001 06:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270438AbRHHKEl>; Wed, 8 Aug 2001 06:04:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19463 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270440AbRHHKE0>; Wed, 8 Aug 2001 06:04:26 -0400
Subject: Re: [Bug]No ATARAID chip, But ATARAID loaded
To: dfbb@linux.net.cn (Fang Han)
Date: Wed, 8 Aug 2001 11:06:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, laughing@shared-source.org (Alan Cox)
In-Reply-To: <20010808154653.B1355@dfbbb.cn.mvd> from "Fang Han" at Aug 08, 2001 03:46:53 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UQE8-0004xy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  ) driver loaded.  And it can see the partitions of 70G IDE HD,
> All partition know as  ataraid1 ataraid5...
>  But when mounting the root filesystem(in hda1) it complain IO 
> error, Then kernl panic.

hda/hdb are the idividual disks. If your root fs is on a ataraid and in
a supported format you want (ie device 114,1) for first partition of the
raid . Try root=7201

for ataraid1 for the partition on the raid


