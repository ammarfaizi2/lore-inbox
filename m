Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVJDH6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVJDH6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 03:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVJDH6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 03:58:13 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:62379 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S964782AbVJDH6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 03:58:13 -0400
Date: Tue, 04 Oct 2005 16:52:16 +0900 (JST)
Message-Id: <20051004.165216.94769788.taka@valinux.co.jp>
To: magnus@valinux.co.jp
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/07] i386: numa emulation on pc
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20050930073308.10631.24247.sendpatchset@cherry.local>
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	<20050930073308.10631.24247.sendpatchset@cherry.local>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This patch adds NUMA emulation for i386 on top of the fixes for sparsemem and
> discontigmem. NUMA emulation already exists for x86_64, and this patch adds
> the same feature using the same config option CONFIG_NUMA_EMU. The kernel
> command line option used is also the same as for x86_64.

It seems like you've forgot to bind cpus with emulated nodes as linux for
x86_64 does. I don't think it's your intention.


Thanks.
