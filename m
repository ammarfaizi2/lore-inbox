Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWDMDiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWDMDiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 23:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWDMDiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 23:38:18 -0400
Received: from pat.uio.no ([129.240.10.6]:24496 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964776AbWDMDiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 23:38:17 -0400
Subject: Re: [PATCH] Use atomic ops for file_nr accounting, not spinlock+irq
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <18424.1144865958@warthog.cambridge.redhat.com>
References: <1144864128.8056.8.camel@lade.trondhjem.org>
	 <20060411150512.5dd6e83d.akpm@osdl.org>
	 <16476.1144773375@warthog.cambridge.redhat.com>
	 <17771.1144839377@warthog.cambridge.redhat.com>
	 <18424.1144865958@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 23:38:03 -0400
Message-Id: <1144899484.8056.28.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.67, required 12,
	autolearn=disabled, AWL 1.33, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 19:19 +0100, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > I've been updating the NFS git tree on a daily basis. I'm not going to
> > begin pulling from the -mm tree, though.
> 
> The thing to which I refer is in Linus's tree but wasn't in yours this
> morning.  Unfortunately, this means my patch has to be different, depending on
> whose tree I'm using... although your tree has been updated since then, so the
> difference seems to have gone away.
> 
> I don't mean to be critical of your efforts, but the requirement imposed by
> Andrew that I have to base my tree on yours makes things a little tricky
> sometimes:-/

You can always pull from Linus too. There is nothing within git that
forces you to wait for me to pull in his changes.

Cheers,
  Trond

