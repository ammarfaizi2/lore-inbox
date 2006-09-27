Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWI0BCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWI0BCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 21:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWI0BCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 21:02:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932193AbWI0BCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 21:02:37 -0400
Date: Tue, 26 Sep 2006 18:02:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Henne <henne@nachtwindheim.de>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: mark pci_module_init() as deprecated 2nd try
Message-Id: <20060926180226.a77976e1.akpm@osdl.org>
In-Reply-To: <45182AF2.30201@nachtwindheim.de>
References: <45182AF2.30201@nachtwindheim.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 21:16:02 +0200
Henne <henne@nachtwindheim.de> wrote:

> Since nearly all pci_module_init()'s are removed from the tree (19 left), heres the patch for
> 2.6.18-git4.
> 
> In the mm-patchset it's called:
> mark-pci_module_init-deprecated.patch
> and can be removed if acked by greg.
> 
> Greets,
> Henne
> 
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Changes the pci_module_init macro into a deprecated inline function.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

You didn't need to send this patch.  I already have it queued up, behind
some more of the pci_module_init-conversion patches, which is the
appropriate place for it.  It's also behind 1,800-odd other patches.

Patience - at 200/day, we'll get there eventually.


