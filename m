Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbUL1Hd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbUL1Hd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 02:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUL1HYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 02:24:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62920 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262104AbUL1GAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 01:00:20 -0500
Date: Tue, 28 Dec 2004 00:59:33 -0500
From: Dave Jones <davej@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Patrick McHardy <kaber@trash.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: kmalloc packet slab
Message-ID: <20041228055933.GA5481@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Patrick McHardy <kaber@trash.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41D04977.2040902@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D04977.2040902@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 06:42:15PM +0100, Manfred Spraul wrote:

 > Hmm. If the shared_info is that large then the patch won't help much.
 > Alan - what is printed in the /proc/slabinfo line for the new cache?

On my laptop which has been up for 5 days, and seen quite a bit
of network traffic over the xmas holidays..

size-1620(DMA)         0      0   1632    5    2 : tunables   24   12    0 : slabdata      0      0      0
size-1620             35     35   1632    5    2 : tunables   24   12    0 : slabdata      7      7      0

		Dave

