Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVCHXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVCHXhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVCHXe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:34:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:17367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262166AbVCHX3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:29:47 -0500
Date: Tue, 8 Mar 2005 15:29:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
Message-Id: <20050308152943.2f19e97f.akpm@osdl.org>
In-Reply-To: <20050308232019.GA20520@infradead.org>
References: <20050308033846.0c4f8245.akpm@osdl.org>
	<20050308232019.GA20520@infradead.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > +sh-merge-updates.patch
> > 
> >  sh/sh64 updates
> 
> btw, it would be nice if you'd give a period of say 48 hours for
> people to review non-critical patches before sending them off to
> Linus.  The sh update was pretty nice, so no coplaints about this
> one, but we had worse things passed on in the past.

Yup, I've asked Paul to cc lkml in the future.

> > +open-iscsi-scsi.patch
> > +open-iscsi-headers.patch
> > +open-iscsi-kconfig.patch
> > +open-iscsi-makefile.patch
> > +open-iscsi-netlink.patch
> > +open-iscsi-doc.patch
> > 
> >  iSCSI driver
> 
> Please don't put this in.  It's fairly experimental and just one
> of three iscsi initiators we're (scsi folks) currently evaluating
> for inclusion.

I'll frequently add things like this just so they get additional
compile-coverage testing and to get wider reviewing.  And someone might run
sparse, checkstack, reference_discarded or reference_init on it.
