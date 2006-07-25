Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWGYJUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWGYJUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWGYJUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:20:05 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:65510 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751518AbWGYJUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:20:04 -0400
To: josht@us.ibm.com
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       fuse-devel@lists.sourceforge.net
In-reply-to: <1153787496.31581.43.camel@josh-work.beaverton.ibm.com> (message
	from Josh Triplett on Mon, 24 Jul 2006 17:31:36 -0700)
Subject: Re: [PATCH] [fuse] Add lock annotations to request_end and
	fuse_read_interrupt
References: <1153787496.31581.43.camel@josh-work.beaverton.ibm.com>
Message-Id: <E1G5J4W-0002CO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Jul 2006 11:19:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> request_end and fuse_read_interrupt release fc->lock.  Add lock annotations to
> these two functions so that sparse can check callers for lock pairing, and so
> that sparse will not complain about these functions since they intentionally
> use locks in this manner.
> 
> Signed-off-by: Josh Triplett <josh@freedesktop.org>

Acked-by: Miklos Szeredi <miklos@szeredi.hu>

Thanks,
Miklos
