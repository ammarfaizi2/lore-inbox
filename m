Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272322AbTHOXKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272337AbTHOXKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:10:50 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:39175 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272322AbTHOXKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:10:00 -0400
Date: Sat, 16 Aug 2003 00:09:58 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] visws: we don't need VGA console !
In-Reply-To: <20030814121905.A32484@infradead.org>
Message-ID: <Pine.LNX.4.44.0308160009300.21319-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I think subject is self explaining :)
> > 
> > BTW does PC-9800 need VGA console ?
> 
> -bool "VGA text console" if EMBEDDED || !X86
> +bool "VGA text console"
> 
> might be a better fix, the depency is completly bogus.

I agree. I like to see this go away.


