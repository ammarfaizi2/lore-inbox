Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVLERYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVLERYc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVLERYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:24:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9936 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932465AbVLERYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:24:31 -0500
Date: Mon, 5 Dec 2005 09:24:18 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] radixtree: sync with mainline
In-Reply-To: <20051205104446.GA6104@mail.ustc.edu.cn>
Message-ID: <Pine.LNX.4.62.0512050923560.11455@schroedinger.engr.sgi.com>
References: <20051203071444.260068000@localhost.localdomain>
 <20051203071625.331743000@localhost.localdomain> <20051204155750.3972c3df.akpm@osdl.org>
 <20051205104446.GA6104@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Wu Fengguang wrote:

>         return slot;
> 
> It should be
> 
>         return &slot;

That wont work. slot is a local variable. Drop this patch please.
