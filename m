Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbUB0VmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUB0Vlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:41:52 -0500
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:41610
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S263151AbUB0VlW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:41:22 -0500
Subject: Re: [NFS SUNRPC] fix
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Xine.LNX.4.44.0402271627190.13899-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0402271627190.13899-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1077918073.5728.18.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 13:41:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 27/02/2004 klokka 13:31, skreiv James Morris:
> The patch below fixes a bug in the error handling code of 
> xprt_create_socket().  If sock_create() fails, we should not try and 
> release the non existent socket.
> 
> This fix is by James Carter <jwcart2@epoch.ncsc.mil>.
> 
> Please apply.

Thanks. I've applied it to my patchsets...

Cheers,
  Trond
