Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWHASIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWHASIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbWHASIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:08:31 -0400
Received: from pat.uio.no ([129.240.10.4]:25486 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750980AbWHASIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:08:30 -0400
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <6189.1154453976@warthog.cambridge.redhat.com>
References: <1154450847.5605.21.camel@localhost>
	 <1154354115351-git-send-email-hskinnemoen@atmel.com>
	 <20060731174659.72da734f@cad-250-152.norway.atmel.com>
	 <1154371259.13744.4.camel@localhost>
	 <20060801101210.0548a382@cad-250-152.norway.atmel.com>
	 <6189.1154453976@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 11:08:10 -0700
Message-Id: <1154455691.5605.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.754, required 12,
	autolearn=disabled, AWL 1.25, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 18:39 +0100, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > +			/* Set the pseudoflavor */
> > +			if (!(data->flags & NFS_MOUNT_SECFLAVOUR))
> > +				data->pseudoflavor = RPC_AUTH_UNIX;
> >  			memset(data->context, 0, sizeof(data->context));
> 
> Should the memset() conditional also?

No. That should be unconditional...

Cheers,
  Trond

