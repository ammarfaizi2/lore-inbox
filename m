Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVHXHcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVHXHcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVHXHcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:32:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55528 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750712AbVHXHcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:32:16 -0400
Date: Wed, 24 Aug 2005 08:32:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] remove ia_attr_flags
Message-ID: <20050824073214.GA24513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 10:24:30PM +0200, Miklos Szeredi wrote:
> Remove unused ia_attr_flags from struct iattr, and related defines.

I had actually planned to make use of this, by adding a common helper
for the ext2-style file flags ioctl so all the checking is moved outside
the filesystems.  OTOH I planned this forever and didn't get ver far,
so it's probably okay to remove it - I can put it back when needed.

