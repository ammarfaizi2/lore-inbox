Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbVJLTzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbVJLTzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbVJLTzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:55:15 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:6660 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751513AbVJLTzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:55:13 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1129143686.8434.64.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Wed, 12 Oct 2005 15:01:26 -0400)
Subject: Re: [RFC] atomic create+open
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
	 <1129061494.11164.38.camel@lade.trondhjem.org>
	 <E1EPeM4-0000Xz-00@dorka.pomaz.szeredi.hu>
	 <1129123257.8561.27.camel@lade.trondhjem.org>
	 <E1EPh1j-0000jR-00@dorka.pomaz.szeredi.hu> <1129143686.8434.64.camel@lade.trondhjem.org>
Message-Id: <E1EPmfK-00019W-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 12 Oct 2005 21:53:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I don't care either way since we will not be supporting non-intent based
> > > opens for NFSv4.
> > 
> > I need this for FUSE, since non-create opens and non-exclusive open of
> > positive dentry will be done through ->open().
> 
> How about something like the following instead? That gives you the
> option of choosing a non-standard initialisation for the intent case,
> with the default being ->open().

Fine by me.

Thanks,
Miklos
