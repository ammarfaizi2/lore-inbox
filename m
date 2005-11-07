Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVKGVaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVKGVaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVKGVaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:30:13 -0500
Received: from postel.suug.ch ([195.134.158.23]:16320 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S964989AbVKGVaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:30:11 -0500
Date: Mon, 7 Nov 2005 22:30:32 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Ashutosh Naik <ashutosh_naik@adaptec.com>
Cc: pablo@eurodev.net, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] lib - Fix broken function declaration in linux/textsearch.h
Message-ID: <20051107213032.GG23537@postel.suug.ch>
References: <1131363741.30115.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131363741.30115.35.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ashutosh Naik <ashutosh_naik@adaptec.com> 2005-11-07 17:12
> This PATCH addresses the issue of the init function pointer in
> lib/ts_bm.c, lib/ts_fsm.c and lib/ts_kmp.c using a mismatching
> definition in linux/textsearch.h

This is already fixed by Al Viro's "[PATCH] gfp_t: lib/*"
