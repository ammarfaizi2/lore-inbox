Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUH2Agi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUH2Agi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 20:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUH2Agf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 20:36:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16324 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266717AbUH2Age (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 20:36:34 -0400
Date: Sun, 29 Aug 2004 02:36:32 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: orlov/nobh
Message-ID: <20040829003630.GA19197@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +oldalloc                   Use old allocator for new inodes.
> > +orlov              (*)     Use Orlov allocator.
> > +
> > +nobh                       Do not attach buffer_heads to file pagecache.
> 
> For these two it would be nice to include a description
> of why you'd want them or a pointer to something
> describing it. An admin trying to squeeze performance out
> of his server might see these options in such documentation
> and then want to know if they can help him.

See http://lwn.net/Articles/14633/ and http://lwn.net/Articles/14446/
for Orlov.

I am not aware of serious benchmark work. Simple direct tests
seem either to show no significant difference or to favor Orlov.
I have never seen a study on fragmentation after extended use
of both allocators.

Concerning nobh, I think that is a toy by Andrew, meant for
very large machines. He is in a better position to comment
(in fact on both orlov and nobh).

Andries
