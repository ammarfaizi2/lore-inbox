Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTD1Wm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTD1Wm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:42:28 -0400
Received: from [12.47.58.171] ([12.47.58.171]:28457 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261364AbTD1Wm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:42:27 -0400
Date: Mon, 28 Apr 2003 15:51:53 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make struct alt_instr acceptable to userland
Message-Id: <20030428155153.44c3976d.akpm@digeo.com>
In-Reply-To: <1051570042.12949.67.camel@serpentine.internal.keyresearch.com>
References: <1051570042.12949.67.camel@serpentine.internal.keyresearch.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2003 22:54:39.0940 (UTC) FILETIME=[26601040:01C30DD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@serpentine.com> wrote:
>
> Andi's new struct alt_instr is visible to klibc.  The attached patch
> changes the types it uses, so that klibc becomes happy.

Should it be inside #ifdef __KERNEL__?


