Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUKCUen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUKCUen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUKCUen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:34:43 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:56583 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261854AbUKCUdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:33:33 -0500
Date: Wed, 3 Nov 2004 20:33:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
Message-ID: <20041103203331.GB23494@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20041103091039.GA22469@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103091039.GA22469@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 01:10:39AM -0800, Chris Wedgwood wrote:
> A separate pci_module_init doesn't really exist anymore so we should
> deprecate this.  Whilst we are at it we should insist any (old) users
> of this and also users of pci_register_driver check their return
> codes.  Whilst doing this we may as well remove some old (unused)
> preprocessor tokens whilst we are at it.

There's nothing bad about it, it's a useless indirection but doesn't
cause harm.

If you want it to be removed submit patches to the drivers using it
instead of adding such warnings.  Once your down to very few drivers
you can deprecate it.
