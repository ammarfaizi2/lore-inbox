Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVJROLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVJROLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVJROLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:11:19 -0400
Received: from gold.veritas.com ([143.127.12.110]:56413 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750755AbVJROLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:11:18 -0400
Date: Tue, 18 Oct 2005 15:10:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: OBATA Noboru <noboru.obata.ar@hitachi.com>
cc: lkml@oxley.org, pavel@ucw.cz, hyoshiok@miraclelinux.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
In-Reply-To: <20051018.224722.126577332.noboru.obata.ar@hitachi.com>
Message-ID: <Pine.LNX.4.61.0510181501380.8233@goblin.wat.veritas.com>
References: <200510121002.59098.lkml@oxley.org>
 <20051018.224722.126577332.noboru.obata.ar@hitachi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Oct 2005 14:11:18.0092 (UTC) FILETIME=[CED850C0:01C5D3ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, OBATA Noboru wrote:
> 
> I have a bitter experience in analyzing a partial dump.  The
> dump completely lacks the PTE pages of user processes and I had
> to give up analysis then.  A partial dump has a risk of failure
> in analysis.

Page tables of user processes are very often essential in a dump.
Data pages of user processes are almost always just a waste of
space and time in a dump.  Please don't judge against partial
dumps on the basis of one that was badly selected.

Hugh
