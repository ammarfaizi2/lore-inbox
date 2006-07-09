Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161128AbWGIUfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbWGIUfR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWGIUfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:35:17 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:48325 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161128AbWGIUfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:35:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
Date: Sun, 9 Jul 2006 22:35:32 +0200
User-Agent: KMail/1.9.3
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B12C74.9090104@fr.ibm.com> <20060709132135.6c786cfb.akpm@osdl.org>
In-Reply-To: <20060709132135.6c786cfb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607092235.32921.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 22:21, Andrew Morton wrote:
> On Sun, 09 Jul 2006 18:19:00 +0200
> Cedric Le Goater <clg@fr.ibm.com> wrote:
> 
> > Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> > 
> > Kernel BUG at ...home/legoater/linux/2.6.18-rc1-mm1/mm/page_alloc.c:252
> 
> 	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
> 
> With your config, __GFP_HIGHMEM=0, so wham.
> 
> I dunno, Christoph.  I think those patches are going to significantly
> increase the number of works-with-my-config, doesnt-with-yours scenarios.

This particular one has no chance to work on x86_64 at all.  So well, which one is it?

Rafael
