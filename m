Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVIUTrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVIUTrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVIUTrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:47:41 -0400
Received: from gold.veritas.com ([143.127.12.110]:2365 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932127AbVIUTrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:47:40 -0400
Date: Wed, 21 Sep 2005 20:47:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jay Lan <jlan@engr.sgi.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <4331B6A0.9010403@engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0509212046090.11239@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com> <20050921192835.GA18347@janus>
 <4331B6A0.9010403@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 19:47:39.0990 (UTC) FILETIME=[530A4F60:01C5BEE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Jay Lan wrote:
> Frank van Maarseveen wrote:
> > 
> > But update_mem_hiwater() is called at various places too, and I guess
> > that covers merely the total_vm increase, not rss.
> 
> That is not true. update_mem_hiwater() also updates hiwater_rss.
> 
> > Maybe above inline should replace update_mem_hiwater()?

Yes, I don't understand what Frank meant there either.

Hugh
