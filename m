Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVIUTxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVIUTxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVIUTxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:53:22 -0400
Received: from gold.veritas.com ([143.127.12.110]:61501 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932146AbVIUTxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:53:21 -0400
Date: Wed, 21 Sep 2005 20:52:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Frank van Maarseveen <frankvm@frankvm.com>
cc: Jay Lan <jlan@engr.sgi.com>, Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <20050921194833.GA18550@janus>
Message-ID: <Pine.LNX.4.61.0509212052150.11309@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com> <20050921192835.GA18347@janus>
 <4331B6A0.9010403@engr.sgi.com> <20050921194833.GA18550@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 19:53:21.0138 (UTC) FILETIME=[1E615D20:01C5BEE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> 
> But shouldn't hiwater_rss be updated via a totally different path? When rss
> changes, total_vm doesn't and vice versa. So maybe there should be _two_
> update functions.

Absolutely, one of the points I made earlier.

Hugh
