Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWASD3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWASD3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWASD3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:29:18 -0500
Received: from [198.99.130.12] ([198.99.130.12]:22473 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964926AbWASD3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:29:17 -0500
Date: Wed, 18 Jan 2006 23:21:04 -0500
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared" bogus error messages
Message-ID: <20060119042104.GC8265@ccure.user-mode-linux.org>
References: <20060118235132.4626.74049.stgit@zion.home.lan> <20060118235522.4626.2825.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118235522.4626.2825.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 12:55:23AM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> -extern struct task_struct *idle_threads[NR_CPUS];
> -

BTW, this isn't the only problem there.  There are three declarations
towards the bottom with struct task_struct in them which have to be moved.

				Jeff
