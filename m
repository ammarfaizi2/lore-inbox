Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUFNKru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUFNKru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 06:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUFNKru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 06:47:50 -0400
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:34319 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S262370AbUFNKrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 06:47:49 -0400
Date: Mon, 14 Jun 2004 12:47:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Christoph Hellwig <hch@infradead.org>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [12/12] fix thread_info.h ignoring __HAVE_THREAD_FUNCTIONS
In-Reply-To: <20040614102352.GA11844@infradead.org>
Message-ID: <Pine.LNX.4.58.0406141246160.10292@scrub.local>
References: <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com>
 <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com>
 <20040614004354.GX1444@holomorphy.com> <20040614004516.GY1444@holomorphy.com>
 <20040614004701.GZ1444@holomorphy.com> <20040614004855.GA1444@holomorphy.com>
 <20040614081639.GI7162@infradead.org> <Pine.LNX.4.58.0406141032210.10292@scrub.local>
 <20040614102352.GA11844@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Jun 2004, Christoph Hellwig wrote:

> ia64 actually has thread_info and task_info in a single allocation and
> uses a thread register to find that one.

Hmm, it's a possible solution, although it rather just works around the 
include mess.

bye, Roman
