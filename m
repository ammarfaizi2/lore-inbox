Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUKYBPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUKYBPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbUKYBNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:13:06 -0500
Received: from spark5.com ([216.180.162.40]:50081 "EHLO bling.spark5.com")
	by vger.kernel.org with ESMTP id S262888AbUKYBMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:12:15 -0500
Date: Wed, 24 Nov 2004 18:48:49 -0600
From: Phil Dier <phil@dier.us>
To: linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041124184849.1c903833.phil@dier.us>
In-Reply-To: <20041124151234.714f30d4.akpm@osdl.org>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<20041124094549.4c51d6d5.phil@dier.us>
	<20041124151234.714f30d4.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004 15:12:34 -0800
Andrew Morton <akpm@osdl.org> wrote:

> You didn't mention the kernel version. 2.6.9 had problems in this
> area, so 2.6.10-rc2 should be better. And there are post-2.6.10-rc2
> fixes which will provide more headroom.
>

Sorry, yes, it is 2.6.9 that I'm using atm. I pushed
/proc/sys/vm/min_free_kbytes up to 2048 (it was at 987 or something)
as Christoph suggested and so far, so good. It was such an infrequent
thing though, it's hard to tell if it did any good. I left some stuff
hammering on the array to run over the holiday break, so hopefully any
bad stuff will shake out. I'll give 2.6.10-rc2+ a whirl when I get back
on monday.


Thanks everyone,

Phil
