Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbUKLWeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUKLWeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbUKLWeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:34:46 -0500
Received: from fsmlabs.com ([168.103.115.128]:21382 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S262644AbUKLWep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:34:45 -0500
Date: Fri, 12 Nov 2004 15:34:01 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] include ordering breaks sysrq on 8250 serial
In-Reply-To: <20041112222710.GD8040@waste.org>
Message-ID: <Pine.LNX.4.61.0411121532440.3388@musoma.fsmlabs.com>
References: <20041112222710.GD8040@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, Matt Mackall wrote:

> This has been pestering me for a couple days, finally dug into it:
> 
> serial_8250.h was including serial_core.h before SUPPORT_SYSRQ was
> getting set up. I suspect this problem exists elsewhere. Tested
> against latest bk snapshot.

Thanks! I tried using it and thought perhaps i had finally conceded to the 
little men in my head!
