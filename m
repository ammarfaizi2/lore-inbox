Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbUKCUzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUKCUzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUKCUvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:51:36 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:55959 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261877AbUKCUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:50:19 -0500
Date: Wed, 3 Nov 2004 12:49:54 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
Message-ID: <20041103204954.GB11010@taniwha.stupidest.org>
References: <20041103091039.GA22469@taniwha.stupidest.org> <20041103203331.GB23494@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103203331.GB23494@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 08:33:31PM +0000, Christoph Hellwig wrote:

> There's nothing bad about it, it's a useless indirection but doesn't
> cause harm.

part of the patch is the __much_check, i redo that and submit that
with some driver fixes later

> If you want it to be removed submit patches to the drivers using it
> instead of adding such warnings.  Once your down to very few drivers
> you can deprecate it.

i'm happy to do so --- but it's not clear to me

  (1) is s/pci_module_init/pci_register_driver/ suffices or something
      else needs to be done

  (2) how this will affect drivers also used in 2.4.x, as jeff pointed
      out some drivers are identical (or could be) for both kernels.
