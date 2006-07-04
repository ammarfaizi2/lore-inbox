Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWGDQXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWGDQXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWGDQXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:23:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24470 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932267AbWGDQXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:23:48 -0400
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <Pine.LNX.4.64.0607040915420.13795@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
	 <20060704120242.GA3386@infradead.org>
	 <Pine.LNX.4.64.0607040806580.13456@schroedinger.engr.sgi.com>
	 <200607041723.46604.ak@suse.de>
	 <Pine.LNX.4.64.0607040915420.13795@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 18:23:40 +0200
Message-Id: <1152030220.3109.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 09:16 -0700, Christoph Lameter wrote:
> On Tue, 4 Jul 2006, Andi Kleen wrote:
> 
> > The 900MB refered to the boundary between NORMAL and HIGHMEM on i386.
> 
> Yikes. So any system with 1MB

1G, but yes.

>  will need to have highmem? I guess the 2G/2G 
> config option changes that?

but that breaks userspace ABI and things that really want a lot of
memory ;)

Thankfully x86-64 is there, and just about all systems sold today do 64
bit.. 

(and highmem is not that bad.. you make it sound as if it's a dirty
word. It's not pretty but it's not THAT evil either)


