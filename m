Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUGZWgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUGZWgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUGZWgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:36:32 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:18074 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266133AbUGZWfb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:35:31 -0400
Subject: Re: bug with multiple mounts of filesystems in 2.6
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: John S J Anderson <jacobs@genehack.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Herbert Poetzl <herbert@13thfloor.at>
In-Reply-To: <41057893.1030006@sun.com>
References: <86oem2hgv8.fsf@mendel.genehack.org>
	 <1090870651.6809.62.camel@lade.trondhjem.org>  <41057893.1030006@sun.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1090881327.6809.111.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 18:35:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 26/07/2004 klokka 17:33, skreiv Mike Waychison:

> How is this any different than having two seperate nfs clients accessing
> the same nfs export?

It isn't, but why do you think that should be a reason for allowing it?

By all means feel free to add "mount --bind -oro" capabilities, but it
is neither useful nor is it necessary to break the NFS caching model in
order to do so.

Cheers,
  Trond
