Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265513AbUAJWON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUAJWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:14:13 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:55273 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265513AbUAJWOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:14:10 -0500
Date: Sat, 10 Jan 2004 14:14:02 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040110221402.GB17845@matchmail.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401102100180.5835-100000@poirot.grange> <1073771855.3958.15.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073771855.3958.15.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 04:57:36PM -0500, Trond Myklebust wrote:
> P? lau , 10/01/2004 klokka 15:04, skreiv Guennadi Liakhovetski:
> > Not change - keep (from 2.4). You see, the problem might be - somebody
> > updates the NFS-server from 2.4 to 2.6 and then suddenly some clients fail
> > to work with it. Seems a non-obvious fact, that after upgrading the server
> > clients' configuration might have to be changed. At the very least this
> > must be documented in Kconfig.
> 
> Non-obvious????? You have to change modutils, you have to upgrade
> nfs-utils, glibc, gcc... and that's only the beginning of the list.
> 
> 2.6.x is a new kernel it differs from 2.4.x, which again differs from
> 2.2.x, ... Get over it! There are workarounds for your problem, so use
> them.

I have to admit, I haven't been following NFS on TCP very much.  Is the code
in the stock 2.4 and 2.6 kernels ready for production use?  It seemed from
what I read it was still experemental (and even marked as such in the
config). 

