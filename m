Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751743AbWBEM3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWBEM3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 07:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWBEM3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 07:29:15 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:15070 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751733AbWBEM3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 07:29:15 -0500
Subject: Re: [RFT/PATCH] slab: consolidate allocation paths
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Jackson <pj@sgi.com>
Cc: christoph@lameter.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       manfred@colorfullife.com
In-Reply-To: <20060204180026.b68e9476.pj@sgi.com>
References: <1139060024.8707.5.camel@localhost>
	 <Pine.LNX.4.62.0602040709210.31909@graphe.net>
	 <1139070369.21489.3.camel@localhost> <1139070779.21489.5.camel@localhost>
	 <20060204180026.b68e9476.pj@sgi.com>
Date: Sun, 05 Feb 2006 14:29:12 +0200
Message-Id: <1139142552.11782.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-04 at 18:00 -0800, Paul Jackson wrote:
>   1) This patch increased the text size of mm/slab.o by 776
>      bytes (ia64 sn2_defconfig gcc 3.3.3), which should be
>      justified.  My naive expectation would have been that
>      such a source code consolidation patch would be text
>      size neutral, or close to it.

I have a version of the patch now that reduces text size on NUMA. You
can find it here (it won't apply on top of cpuset though):

http://www.cs.helsinki.fi/u/penberg/linux/penberg-2.6/penberg-01-slab/

I'll wait until the cpuset patches have been settled down and repost.

			Pekka

