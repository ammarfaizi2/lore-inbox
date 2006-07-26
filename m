Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWGZSTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWGZSTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWGZSTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:19:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35521 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751742AbWGZSTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:19:30 -0400
Date: Wed, 26 Jul 2006 11:19:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
In-Reply-To: <44C7AF31.9000507@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0607261118001.6608@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
 <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
 <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
 <20060726101340.GE9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI>
 <20060726105204.GF9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
 <44C7AF31.9000507@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Manfred Spraul wrote:

> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

Good bye to all those cacheline contentions that helped us find so many 
race conditions in the past if we switched on SLAB_DEBUG. I thought this 
was intentional?


