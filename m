Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVJFSmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVJFSmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVJFSmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:42:44 -0400
Received: from pat.uio.no ([129.240.130.16]:36604 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751296AbVJFSmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:42:43 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jamie Lokier <jamie@shareable.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20051006175940.GA19766@mail.shareable.org>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <1128618447.8396.39.camel@lade.trondhjem.org>
	 <E1ENZTJ-0003Mm-00@dorka.pomaz.szeredi.hu>
	 <1128620196.16534.20.camel@lade.trondhjem.org>
	 <20051006175940.GA19766@mail.shareable.org>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 14:42:33 -0400
Message-Id: <1128624153.31797.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.507, required 12,
	autolearn=disabled, AWL 1.49, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 06.10.2005 Klokka 18:59 (+0100) skreiv Jamie Lokier:

> > Intents are there in order to allow the filesystem to determine which
> > operation is calling lookup so that it can optimise for that particular
> > operation.
> 
> I think Miklos' point is that it's not an "optimisation" because it's
> not optional.  Optimisations are things where if you don't do them,
> the behaviour is still correct but slower.
> 
> As far as I can tell from this discussion, the atomic lookup+create is
> a non-optional requirement.

By that definition, intents have _never_ been optional. NFSv3/v4 O_EXCL
creates have never worked correctly without them.

Cheers,
  Trond

