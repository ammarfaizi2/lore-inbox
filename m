Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbULPEBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbULPEBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 23:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbULPEBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 23:01:39 -0500
Received: from ns.suse.de ([195.135.220.2]:10126 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261920AbULPEBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 23:01:38 -0500
Date: Thu, 16 Dec 2004 05:01:37 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041216040136.GA30555@wotan.suse.de>
References: <p73acsg1za1.fsf@bragg.suse.de> <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk> <20041215044927.GF27225@wotan.suse.de> <1103155782.3585.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103155782.3585.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 12:09:44AM +0000, Alan Cox wrote:
> On Mer, 2004-12-15 at 04:49, Andi Kleen wrote:
> > I think that's definitely the wrong way. Also in Linux 
> > the standard strategy is to first clean up and restructure/refactor 
> > code and then merge, not the other way round.
> 
> Must be two different Linux OS's out there then. I thought it was
> - get interfaces right

That is exactly the part that is wrong currently imho. The arch/xen
interface is a mess and in its current form unlikely to be maintainable.

-Andi
