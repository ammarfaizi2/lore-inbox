Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVHKOHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVHKOHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVHKOHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:07:20 -0400
Received: from gold.veritas.com ([143.127.12.110]:28842 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750719AbVHKOHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:07:17 -0400
Date: Thu, 11 Aug 2005 15:09:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: coywolf@lovecn.org
cc: Andrew Morton <akpm@osdl.org>, Magnus Damm <magnus.damm@gmail.com>,
       mel@csn.ul.ie, linux-kernel@vger.kernel.org
Subject: Re: How to reclaim inode pages on demand
In-Reply-To: <2cd57c900508110209de388f2@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508111508030.11118@goblin.wat.veritas.com>
References: <Pine.LNX.4.58.0508081650160.26013@skynet> 
 <20050808160844.04d1f7ac.akpm@osdl.org>  <Pine.LNX.4.58.0508101730441.11984@skynet>
  <20050810101714.147e1333.akpm@osdl.org>  <aec7e5c30508102008b739a6c@mail.gmail.com>
  <20050811144441.54b6ef4a.akpm@osdl.org> <2cd57c900508110209de388f2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Aug 2005 14:07:15.0509 (UTC) FILETIME=[FA2A1650:01C59E7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Coywolf Qi Hunt wrote:
> 
> at http://sosdg.org/~coywolf/lxr/source/include/linux/mm.h#L561
> Should the comment be s/page_mapped/page->mapping/ ?

No.
