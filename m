Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVCOGMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVCOGMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVCOGMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:12:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36812 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262276AbVCOGML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:12:11 -0500
Date: Mon, 14 Mar 2005 22:10:45 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: nikita@clusterfs.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm counter operations through macros
In-Reply-To: <20050314215958.15544c65.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503142209511.16889@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110422150.19280@schroedinger.engr.sgi.com>
 <20050311182500.GA4185@redhat.com> <Pine.LNX.4.58.0503111103200.22240@schroedinger.engr.sgi.com>
 <16946.62799.737502.923025@gargle.gargle.HOWL>
 <Pine.LNX.4.58.0503142103090.16582@schroedinger.engr.sgi.com>
 <20050314214506.050efadf.akpm@osdl.org> <Pine.LNX.4.58.0503142148510.16812@schroedinger.engr.sgi.com>
 <20050314215958.15544c65.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Andrew Morton wrote:

> >  Then you wont be able to get rid of the counters by
> >
> >  #define MM_COUNTER(xx)
> >
> >  anymore.
>
> Why would we want to do that?

If counters are calculated on demand then no counter is
necessary.

