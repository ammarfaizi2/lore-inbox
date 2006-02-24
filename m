Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWBXM6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWBXM6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWBXM6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:58:36 -0500
Received: from gold.veritas.com ([143.127.12.110]:40580 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750822AbWBXM6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:58:35 -0500
X-IronPort-AV: i="4.02,143,1139212800"; 
   d="scan'208"; a="56077666:sNHT29435128"
Date: Fri, 24 Feb 2006 12:59:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Alan Cox <alan@redhat.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, mchehab@infradead.org, akpm@osdl.org
Subject: Re: + add-cpia2-camera-support.patch added to -mm tree
In-Reply-To: <20060224111656.GA3136@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.61.0602241256150.17767@goblin.wat.veritas.com>
References: <200602240049.k1O0nuQn023548@shell0.pdx.osdl.net>
 <1140772015.2874.14.camel@laptopd505.fenrus.org> <20060224111656.GA3136@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Feb 2006 12:58:35.0342 (UTC) FILETIME=[05BB3EE0:01C63942]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Alan Cox wrote:
> On Fri, Feb 24, 2006 at 10:06:55AM +0100, Arjan van de Ven wrote:
> > you are adding rvmalloc copy number 14; seems you own the task to make
> > it generic now ;)
> > Also I thought SetPageReserved and friends are deprecated :)
> 
> Heading that way, which is fine by me.

Just go with what you have: one day one of us will come along and
vanish all those rvmallocs and SetPageReserveds; but until that day
it's easiest for everyone if you continue with your rvmalloc #14.

Hugh
