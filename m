Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVF2KXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVF2KXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVF2KXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:23:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:34273 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262502AbVF2KXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:23:18 -0400
Date: Wed, 29 Jun 2005 12:23:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>, penberg@cs.helsinki.fi,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
In-Reply-To: <20050629001717.65fb272c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0506291215330.3743@scrub.home>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
 <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
 <20050628163114.6594e1e1.akpm@osdl.org> <20050629070729.GB16850@infradead.org>
 <20050629001717.65fb272c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 29 Jun 2005, Andrew Morton wrote:

> Come to think of it, it could be a problem if the comnpiler was silly and
> built an entire temporary on the stack and the copied it over.  Hopefull it
> won't do that.

It's not really silly, it's exactly what the compiler will do in such 
case, unless the final memcpy() is small enough to be inlined.

bye, Roman
