Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUABAqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUABAqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:46:52 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:3968
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S262038AbUABAqv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:46:51 -0500
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040101151516.236cb610.pj@sgi.com>
References: <20040101043333.186a3268.pj@sgi.com>
	 <1072977297.1399.14.camel@nidelv.trondhjem.org>
	 <20040101151516.236cb610.pj@sgi.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073004403.1376.14.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 19:46:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 01/01/2004 klokka 18:15, skreiv Paul Jackson:

> Have you knowledge that more recent versions of gcc don't complain
> nearly as much of this warning?  If so, I will upgrade my gcc and shut
> up.

I haven't checked with Andrew's '-mm' kernels, but AFAICS I'm not seeing
any lingering signed/unsigned warnings in the stock 2.6.0 kernel -
certainly not as many as 1386... (GCC version is latest 3.3.3 prerelease
from Debian).

You mentioned Richard Gooch's name cropping up in the broken code, does
that perhaps mean devfs? If so then the warnings may just reflect the
fact that this code has been unmaintained for too long (devfs has after
all been marked as "obsolete").

Cheers,
   Trond
