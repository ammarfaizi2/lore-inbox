Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVK3Pf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVK3Pf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVK3Pf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:35:59 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:1039 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1751411AbVK3Pf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:35:58 -0500
To: "lu richard" <kernel_newbie@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAT:Filesystem panic
References: <BAY17-F8BAEF78DED80E0A856A08994A0@phx.gbl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 01 Dec 2005 00:35:37 +0900
In-Reply-To: <BAY17-F8BAEF78DED80E0A856A08994A0@phx.gbl> (lu richard's message of "Wed, 30 Nov 2005 18:35:09 +0800")
Message-ID: <874q5u87xy.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"lu richard" <kernel_newbie@hotmail.com> writes:

> Now I expect kernel don't create an uncomplete file when pulling out
> MMC card,
> How can I do?

"-o sync" will help some situations, but probably it is very slow on MMC.
The option may be needed to remove the undependent updates for
hotplugging device.

Or implement the SoftUpdates or such. But, since MMC seems to use the
flash, so it may break at device level.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
