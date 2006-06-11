Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWFKKMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWFKKMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 06:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWFKKMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 06:12:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:54152 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750876AbWFKKMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 06:12:46 -0400
Date: Sun, 11 Jun 2006 12:12:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robin H. Johnson" <robbat2@gentoo.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time moving backwards.
In-Reply-To: <20060609224936.GA30611@curie-int.vc.shawcable.net>
Message-ID: <Pine.LNX.4.61.0606111210460.13585@yvahk01.tjqt.qr>
References: <20060609224936.GA30611@curie-int.vc.shawcable.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Test output from a filesystem supporting sub-second timestamps (jfs,xfs,ramfs):
>creat:   m=1149891452.928796249 c=1149891452.928796249 a=1149891452.928796249
>futimes: m=1149891452.928796249 c=1149891452.928796249 a=1149891452.928796249
>
>Test output from the tmpfs filesystem with the patch below:
>creat:   m=1149892086.382150894 c=1149892086.382150894 a=1149892075.473249075
>futimes: m=1149892086.383150885 c=1149892086.383150885 a=1149892086.383150885
>
Is it normal that creat and futimes match for jfs/xfs?


>Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
>
Hint: Cc it to the shmem.c maintainer, or it may get missed :)



Jan Engelhardt
-- 
