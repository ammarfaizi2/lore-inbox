Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbUBQLow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 06:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUBQLow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 06:44:52 -0500
Received: from ns.suse.de ([195.135.220.2]:48854 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266118AbUBQLou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 06:44:50 -0500
Date: Wed, 18 Feb 2004 02:39:21 +0100
From: Andi Kleen <ak@suse.de>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: pavel@ucw.cz, akale@users.sourceforge.net, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net, jim.houston@ccur.com,
       trini@kernel.crashing.org
Subject: Re: hweight64
Message-Id: <20040218023921.60d8a037.ak@suse.de>
In-Reply-To: <200402171655.44006.amitkale@emsyssoft.com>
References: <20040217103451.GA440@elf.ucw.cz>
	<200402171655.44006.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 16:55:43 +0530
"Amit S. Kale" <amitkale@emsyssoft.com> wrote:

> Hi Pavel and kgdb gurus,
> 
> I inherited this change from x86_64 patch. Probably it was required on x86_64. 
> I can't think of any reason why it is necessary.
> 
> Unless someone finds a problem with this patch, I am going to apply it.

You can just remove it. It's not needed. kgdb does not even use hweight*

I checked some time ago with Jim Houston (from which it originated) and he said 
it was a merging error leaking from some Concurrent internal tree.

-Andi
