Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWDAXVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWDAXVN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 18:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWDAXVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 18:21:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932299AbWDAXVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 18:21:12 -0500
Date: Sat, 1 Apr 2006 15:20:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 09/10] RTC subsystem, VR41XX driver
Message-Id: <20060401152016.710a4588.akpm@osdl.org>
In-Reply-To: <20060331100424.813374000@towertech.it>
References: <20060331100423.175139000@towertech.it>
	<20060331100424.813374000@towertech.it>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Zummo <a.zummo@towertech.it> wrote:
>
> This patch updates VR4100 series RTC driver.

It also renames the driver's .c file.  This makes it quite hard for
reviewers to see what was changed.

When you have patches which move large amounts of code around, please make
sure that the patch does *only* that.  Functional changes should happen in
later patches.

