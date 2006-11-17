Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753140AbWKQWBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbWKQWBt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbWKQWBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:01:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753140AbWKQWBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:01:48 -0500
Date: Fri, 17 Nov 2006 14:00:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] Make x86_64 udelay() round up instead of down -
 try2
Message-Id: <20061117140050.7f19acf8.akpm@osdl.org>
In-Reply-To: <20061117193047.13096.60874.stgit@americanbeauty.home.lan>
References: <20061101163043.GA2602@elf.ucw.cz>
	<20061117193047.13096.60874.stgit@americanbeauty.home.lan>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 20:30:47 +0100
"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:

> Port two patches from i386 to x86_64 delay.c to make sure all rounding is done
> upward instead of downward.

Andi already has a patch in his, tree, only it's different.

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/make-x86_64-udelay-round-up-instead-of-down.
