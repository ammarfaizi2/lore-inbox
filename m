Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWAKGKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWAKGKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWAKGKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:10:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4322 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751379AbWAKGKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:10:51 -0500
Date: Tue, 10 Jan 2006 22:10:37 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH 0/5] Direct Migration V9: Overview
In-Reply-To: <43C47AD9.10800@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0601102208560.20806@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
 <43C47AD9.10800@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, KAMEZAWA Hiroyuki wrote:

> By the way, what is the limitation of migratable pages ?
> I think  current limitation is just Hugetlb pages and mlocked pages. right ?

Hugetlb is the only limitation. I have a patch here to allow the moving of 
mlocked pages. Basically one only needs to guarantee that those are not 
swapped out. But I'd like to wait with that for awhile.

> Could you make it clear and add comment or doc before going to -mm ?

Will add a patch to that effect.

