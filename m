Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWGDQQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWGDQQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWGDQQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:16:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44009 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932235AbWGDQQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:16:52 -0400
Date: Tue, 4 Jul 2006 09:16:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
In-Reply-To: <200607041723.46604.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0607040915420.13795@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
 <20060704120242.GA3386@infradead.org> <Pine.LNX.4.64.0607040806580.13456@schroedinger.engr.sgi.com>
 <200607041723.46604.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006, Andi Kleen wrote:

> The 900MB refered to the boundary between NORMAL and HIGHMEM on i386.

Yikes. So any system with 1MB will need to have highmem? I guess the 2G/2G 
config option changes that?


