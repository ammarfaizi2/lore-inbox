Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUAGSVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266278AbUAGSTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:19:49 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:39151 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S266279AbUAGSTd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:19:33 -0500
Date: Wed, 7 Jan 2004 10:19:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040107181920.GN1882@matchmail.com>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040107174939.GK1882@matchmail.com> <Pine.LNX.4.44.0401071908320.1840-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401071908320.1840-100000@poirot.grange>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 07:13:46PM +0100, Guennadi Liakhovetski wrote:
> On Wed, 7 Jan 2004, Mike Fedyk wrote:
> 
> > On Tue, Jan 06, 2004 at 01:46:30AM +0100, Guennadi Liakhovetski wrote:
> > > It is not just a problem of 2.6 with those specific network configurations
> > > - ftp / http / tftp transfers work fine. E.g. wget of the same file on the
> > > PXA with 2.6.0 from the PC1 with 2.4.21 over http takes about 2s. So, it
> > > is 2.6 + NFS.
> > >
> > > Is it fixed somewhere (2.6.1-rcx?), or what should I try / what further
> > > information is required?
> >
> > You will probably need to look at some tcpdump output to debug the problem...
> 
> Yep, just have done that - well, they differ... First obvious thing that I
> noticed is that 2.6 is trying to read bigger blocks (32K instead of 8K),

You mean it's trying to do 32K nfs block size on the wire?

> The bz2 tarball is 50k big, so, not too bad for the list either, but it is
> not a common practice to send compressed attachments to the list, right?
> It's 5M uncompressed.

Just post a few samples of the lines that differ.  Any files should be sent
off-list.
