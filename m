Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbVJGRgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbVJGRgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbVJGRgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:36:25 -0400
Received: from pat.uio.no ([129.240.130.16]:23273 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030488AbVJGRgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:36:24 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENvzx-0005VT-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
	 <1128692289.8519.75.camel@lade.trondhjem.org>
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
	 <1128698035.8583.36.camel@lade.trondhjem.org>
	 <E1ENu8h-0005Kd-00@dorka.pomaz.szeredi.hu>
	 <1128702227.8583.69.camel@lade.trondhjem.org>
	 <E1ENvzx-0005VT-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 13:36:11 -0400
Message-Id: <1128706571.8583.111.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.874, required 12,
	autolearn=disabled, AWL 1.13, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 07.10.2005 Klokka 19:27 (+0200) skreiv Miklos Szeredi:

> Are you planning to post a patch?  Atomic open+create is something
> that FUSE wants as well, so it would be nice to get a proper solution
> into the kernel.

I've got an updated patch in testing right now. I just want to try to
tighten up the intent interface a tad more in order to avoid struct
nameidata initialisation bugs.

Cheers,
  Trond

