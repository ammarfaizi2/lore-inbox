Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWFNFO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWFNFO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWFNFO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:14:57 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:34779 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S964873AbWFNFO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:14:56 -0400
Date: Wed, 14 Jun 2006 07:14:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [patch] s390: missing ifdef in bitops.h
Message-ID: <20060614051427.GA9442@osiris.boeblingen.de.ibm.com>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com> <1150211828.2844.20.camel@hades.cambridge.redhat.com> <200606132233.07830.arnd@arndb.de> <1150231176.11159.110.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150231176.11159.110.camel@shinybook.infradead.org>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 10:39:36PM +0100, David Woodhouse wrote:
> On Tue, 2006-06-13 at 22:33 +0200, Arnd Bergmann wrote:
> > I'd suggest using only one version. In doubt, I would move the parisc
> > version to asm-generic/fd_set.h or similar and include that from
> > everywhere. 
> 
> That makes sense. It's not _entirely_ trivial though, so I don't want to
> do it in my hdrcleanup-2.6.git tree. I'll leave it for later.

In that case it would be good to get Cedric's bitops patch merged, since it
fixes compilation.
