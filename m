Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263499AbTDCTOW 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263493AbTDCTNH 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:13:07 -0500
Received: from [12.47.58.55] ([12.47.58.55]:18035 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263485AbTDCTKn 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:10:43 -0500
Date: Thu, 3 Apr 2003 11:22:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.66-mm3 with contest
Message-Id: <20030403112248.286e5a85.akpm@digeo.com>
In-Reply-To: <200304032348.48118.kernel@kolivas.org>
References: <200304032348.48118.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2003 19:22:04.0330 (UTC) FILETIME=[4F1CB0A0:01C2FA16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
> 
> Seems these "minor" scheduler tweaks cause major changes to the results with 
> process load and most of the io based loads taking significantly less time. 
> There weren't any elevator changes in this one were there?

The process_load shift was presumably due to the CPU scheduler change.

The others would be due to the reversion of an anticipatory scheduler patch,
as-queue_notready-cleanup.patch.

