Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbUJYJIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUJYJIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUJYJIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:08:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:38863 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261708AbUJYJIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:08:48 -0400
Subject: Re: Concerns about our pci_{save,restore}_state()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <1098693129.2798.9.camel@laptop.fenrus.org>
References: <1098677182.26697.21.camel@gaston>  <417C991C.2070806@pobox.com>
	 <1098685464.26695.32.camel@gaston>
	 <1098693129.2798.9.camel@laptop.fenrus.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 19:04:49 +1000
Message-Id: <1098695089.31118.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 10:32 +0200, Arjan van de Ven wrote:
> On Mon, 2004-10-25 at 16:24 +1000, Benjamin Herrenschmidt wrote:
> 
> > Currently, the default does nothing (doesn't even save/restore).
> 
> Are you sure? I could have sworn I made the default action to
> save/restore some time ago

You are right, I was watching an outdated file for some strange reason I
won't get into now :)

However, it doesn't seem to save/restore enough for a P2P bridge..

Ben.


