Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWBEDpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWBEDpF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 22:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWBEDpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 22:45:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36748 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932590AbWBEDpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 22:45:03 -0500
Date: Sat, 4 Feb 2006 19:44:45 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, christoph@lameter.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       manfred@colorfullife.com
Subject: Re: [RFT/PATCH] slab: consolidate allocation paths
In-Reply-To: <20060204180026.b68e9476.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0602041941570.9005@schroedinger.engr.sgi.com>
References: <1139060024.8707.5.camel@localhost> <Pine.LNX.4.62.0602040709210.31909@graphe.net>
 <1139070369.21489.3.camel@localhost> <1139070779.21489.5.camel@localhost>
 <20060204180026.b68e9476.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Paul Jackson wrote:

>   1) This patch increased the text size of mm/slab.o by 776
>      bytes (ia64 sn2_defconfig gcc 3.3.3), which should be
>      justified.  My naive expectation would have been that
>      such a source code consolidation patch would be text
>      size neutral, or close to it.

Hmmm... Maybe its worth a retry with gcc 3.4 and 4.X? Note that the
size increase may be much less on i386. The .o file includes descriptive
material too...

