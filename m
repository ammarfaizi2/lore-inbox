Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUFEKuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUFEKuC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 06:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUFEKuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 06:50:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:32387 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266069AbUFEKuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 06:50:00 -0400
Date: Sat, 5 Jun 2004 12:48:00 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: anton@samba.org, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
Message-Id: <20040605124800.0b098fdd.ak@suse.de>
In-Reply-To: <20040605122239.4a73f5e8.ak@suse.de>
References: <20040605034356.1037d299.ak@suse.de>
	<40C12865.9050803@colorfullife.com>
	<20040605041813.75e2d22d.ak@suse.de>
	<20040605023211.GA16084@krispykreme>
	<20040605122239.4a73f5e8.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2004 12:22:39 +0200
Andi Kleen <ak@suse.de> wrote:


> Have you ever tried to switch to implement a vmalloc_interleave() for these
> tables instead? My bet is that it will perform better.

Actually vmalloc_interleaved() is not needed. With process interleaving
policy a ordinary vmalloc() should do that already.

-Andi
