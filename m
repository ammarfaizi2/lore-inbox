Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSL2Wcd>; Sun, 29 Dec 2002 17:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSL2Wcd>; Sun, 29 Dec 2002 17:32:33 -0500
Received: from verein.lst.de ([212.34.181.86]:49675 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262038AbSL2Wcc>;
	Sun, 29 Dec 2002 17:32:32 -0500
Date: Sun, 29 Dec 2002 23:40:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove CONFIG_X86_NUMA
Message-ID: <20021229234051.A12535@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <200212292239.gBTMdPJ12407@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212292239.gBTMdPJ12407@localhost.localdomain>; from James.Bottomley@steeleye.com on Sun, Dec 29, 2002 at 04:39:25PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 04:39:25PM -0600, James Bottomley wrote:
> > It's only used to hide two entries in arch/i386/Kconfig.
> 
> The patch looks good.  If it's OK to get rid of X86_NUMA, could you also move 
> X86_NUMAQ under the subarch menu?

I already wondered about that, but AFAIK a kernel with X86_NUMAQ set
still boots on a PeeCee, so it's really an option, not a choice.

