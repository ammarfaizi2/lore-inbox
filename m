Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVF2HyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVF2HyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVF2HxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:53:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15568 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262480AbVF2HuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:50:22 -0400
Date: Wed, 29 Jun 2005 08:50:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: freevxfs: minor cleanups
Message-ID: <20050629075019.GA17982@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka J Enberg <penberg@cs.helsinki.fi>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi> <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi> <20050628163114.6594e1e1.akpm@osdl.org> <1120018821.9658.4.camel@localhost> <20050629070814.GC16850@infradead.org> <courier.42C250EF.00000B88@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42C250EF.00000B88@courier.cs.helsinki.fi>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 10:42:39AM +0300, Pekka J Enberg wrote:
> 
> I agree that pointer initialization is not really an issue but I do prefer 
> the C99 struct initializers over an kcalloc(1, sizeof(*p)) call. 
> 
> Is this something you don't want for freevxfs or filesystems in general? 
> Should it be removed from NTFS as well? 

I don't have control over NTFS, but please don't introduce this idiom
anywhere else.

