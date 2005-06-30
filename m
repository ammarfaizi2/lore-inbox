Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVF3JwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVF3JwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVF3JwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:52:08 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:11525 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262918AbVF3JwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:52:05 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20050630022752.079155ef.akpm@osdl.org> (message from Andrew
	Morton on Thu, 30 Jun 2005 02:27:52 -0700)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org>
Message-Id: <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Jun 2005 11:51:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What's up with FUSE merging?  Is there anything pending that I should
> >  do?
> 
> Where are we up to with the fuse_allow_task() bunfight?

I think we agreed, that there seem to be no alternatives.

Tytso said, that fuse_allow_task() thing is basically OK, but there
should be some method to make certain tasks excempt from this
limitation.  I agree, with this, but I think there should be at least
one (preferably more) users who actually need this, before I start
thinking about implementing it.

Making a mount be excepmt is already possible with the 'allow_other'
(privileged by default) mount option.

Miklos
