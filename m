Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVHDGQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVHDGQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVHDGQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:16:50 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:58833 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261861AbVHDGJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:09:45 -0400
Date: Thu, 4 Aug 2005 08:09:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Daniel Walter <walter@mbo.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS crashing
In-Reply-To: <42F0ADEE.7020405@mbo.de>
Message-ID: <Pine.LNX.4.61.0508040808000.22272@yvahk01.tjqt.qr>
References: <42F0ADEE.7020405@mbo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Acessing the (software-)raid1 results in crash of shell
> raid worked ok for some days before
> error message appeared upon first hangup:
>
>
> Linux version 2.6.11.10BERNHADINERMBO.DE (root@shepard) (gcc version 3.3.4) #3
> Fri Jul 15 11:53:00 CEST 2005
>
>
> ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.6* [2
> 2690 0x0 SD], item_len 492, item_location 3836, free_space(entry_count) 65535
> ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in block
> 720896. Fsck?

Try do a reiserfsck. If it's gone then, it should be ok.


