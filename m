Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWH2URj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWH2URj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWH2URj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:17:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60888 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964931AbWH2URi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:17:38 -0400
Date: Tue, 29 Aug 2006 13:16:28 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060829201628.GA13807@kroah.com>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <1156857214.5613.72.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156857214.5613.72.camel@aeonflux.holtmann.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 03:13:34PM +0200, Marcel Holtmann wrote:
> Hi James,
> 
> > From: Jon Masters <jcm@redhat.com>
> > 
> > Right now, various kernel modules are being migrated over to use
> > request_firmware in order to pull in binary firmware blobs from userland
> > when the module is loaded. This makes sense.
> > 
> > However, there is right now little mechanism in place to automatically
> > determine which binary firmware blobs must be included with a kernel in
> > order to satisfy the prerequisites of these drivers. This affects
> > vendors, but also regular users to a certain extent too.
> > 
> > The attached patch introduces MODULE_FIRMWARE as a mechanism for
> > advertising that a particular firmware file is to be loaded - it will
> > then show up via modinfo and could be used e.g. when packaging a kernel.
> 
> this patch was debated, but we never came to a final conclusion. I am
> all for it. It is simple and can improve the current situation.
> 
> > Signed-off-by: Jon Masters <jcm@redhat.com>
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Since your tree will depend on this change, you can add it there and
add:

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

from me to the patch.

thanks,

greg k-h
