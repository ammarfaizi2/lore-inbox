Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVBSR0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVBSR0K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 12:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVBSR0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 12:26:10 -0500
Received: from quechua.inka.de ([193.197.184.2]:27863 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261747AbVBSR0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 12:26:08 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [ANNOUNCE] yaird, a mkinitrd based on hotplug concepts
Date: Sat, 19 Feb 2005 18:28:02 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.02.19.17.28.01.674334@dungeon.inka.de>
References: <20050217210620.A20645@banaan.localdomain>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it looks like yaird does use pivot_root.
however pivot_root and initramfs cause a kernel crash
(once you unmount /initrd in the real system).
use run-init from klibc instead and you are fine.

Andreas

