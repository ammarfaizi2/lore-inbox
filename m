Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUIEOEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUIEOEi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUIEOEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:04:38 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:53491 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266748AbUIEOCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:02:21 -0400
Date: Sun, 5 Sep 2004 10:06:46 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Anton Blanchard <anton@samba.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Correct ELF section used for out of line spinlocks
In-Reply-To: <20040905071549.GH7716@krispykreme>
Message-ID: <Pine.LNX.4.53.0409051005310.14053@montezuma.fsmlabs.com>
References: <20040905071549.GH7716@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004, Anton Blanchard wrote:

> The vmlinux.lds is using .lock.text but __lockfunc was using
> .spinlock.text.

Thanks Anton, big booboo, i had changed the name of the section in the 
link scripts last minute (since it covered more than spinlocks).

	Zwane

