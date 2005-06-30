Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVF3KAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVF3KAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVF3KAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:00:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40941 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262922AbVF3KAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:00:13 -0400
Subject: Re: FUSE merging?
From: Arjan van de Ven <arjan@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <20050630022752.079155ef.akpm@osdl.org>
	 <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 12:00:05 +0200
Message-Id: <1120125606.3181.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 11:51 +0200, Miklos Szeredi wrote:
> > > What's up with FUSE merging?  Is there anything pending that I should
> > >  do?
> > 
> > Where are we up to with the fuse_allow_task() bunfight?
> 
> I think we agreed, that there seem to be no alternatives.
> 
> Tytso said, that fuse_allow_task() thing is basically OK, but there
> should be some method to make certain tasks excempt from this
> limitation.  I agree, with this, but I think there should be at least
> one (preferably more) users who actually need this, before I start
> thinking about implementing it.
> 
> Making a mount be excepmt is already possible with the 'allow_other'
> (privileged by default) mount option.

if you are so interested in getting fuse merged... why not merge it
first with the security stuff removed entirely. And then start
discussing putting security stuff back in ?


