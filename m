Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVCaVS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVCaVS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVCaVS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:18:26 -0500
Received: from rev.193.226.232.24.euroweb.hu ([193.226.232.24]:11955 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261984AbVCaVSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:18:23 -0500
To: joe@perches.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <1112302930.7436.5.camel@localhost.localdomain> (message from Joe
	Perches on Thu, 31 Mar 2005 13:02:10 -0800)
Subject: Re: [PATCH] FUSE: 1/3 add padding
References: <E1DH6go-00016V-00@dorka.pomaz.szeredi.hu> <1112302930.7436.5.camel@localhost.localdomain>
Message-Id: <E1DH72l-0001Av-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 31 Mar 2005 23:17:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please reply to all, lkml and akpm restored in CC)

> > Add padding to structures to make sizes the same on 32bit and 64bit
> > archs.  Initial testing and test machine generously provided by Franco
> > Broi.
> 
> __attribute__((aligned(8))) ?

I'll try that.

Thanks,
Miklos
