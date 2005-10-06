Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVJFRIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVJFRIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVJFRIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:08:06 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:29449 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751155AbVJFRID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:08:03 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Thu, 06 Oct 2005 19:02:52 +0200)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu> <1128616864.8396.32.camel@lade.trondhjem.org> <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 19:06:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason why we do it as a lookup intent is because this has to be
> atomic lookup+create+open in order to be at all useful to NFS.

Oh, and btw there's a problem with atomic lookup+create+open: mounts.
Do you want to follow mounts inside ->lookup().  Ugly.

Miklos


