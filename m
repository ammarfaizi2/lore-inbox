Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTDDDkC (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 22:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbTDDDkC (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 22:40:02 -0500
Received: from [12.47.58.55] ([12.47.58.55]:46788 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261321AbTDDDj6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 22:39:58 -0500
Date: Thu, 3 Apr 2003 19:52:07 -0800
From: Andrew Morton <akpm@digeo.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm3: hang and crash
Message-Id: <20030403195207.737621f5.akpm@digeo.com>
In-Reply-To: <20030404031402.GA457@zip.com.au>
References: <20030404013732.GA466@zip.com.au>
	<20030403183604.6a4cc385.akpm@digeo.com>
	<20030404031402.GA457@zip.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 03:51:19.0712 (UTC) FILETIME=[7389FA00:01C2FA5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
>
> Still, the linus.patch produced the same result. If you think it's
> worthwhile I'll compile out the fa and perc patchesb but I didn't think
> it significant due to them workign just fine with 2.5.66.

Well you've already worked out that the problem is due to the i2c and/or
sensors changes, yes?

That's the area to start backing stuff out to work out where it broke.
