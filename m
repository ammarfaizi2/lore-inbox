Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbSJWLbH>; Wed, 23 Oct 2002 07:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJWLbH>; Wed, 23 Oct 2002 07:31:07 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:45502 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261223AbSJWLbG>; Wed, 23 Oct 2002 07:31:06 -0400
Subject: Re: [miniPATCH] 2.5.44 fix compilation errors in the AFS fs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander.Riesen@synopsys.com
Cc: Jan Marek <linux@hazard.jcu.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021023104213.GB3512@riesen-pc.gr05.synopsys.com>
References: <20021023095601.GB12175@hazard.jcu.cz>
	<1035368896.3968.31.camel@irongate.swansea.linux.org.uk> 
	<20021023104213.GB3512@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 12:53:45 +0100
Message-Id: <1035374025.4033.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 11:42, Alex Riesen wrote:
> On Wed, Oct 23, 2002 at 11:28:16AM +0100, Alan Cox wrote:
> > On Wed, 2002-10-23 at 10:56, Jan Marek wrote:
> > > The first of them fixed union afs_dirent_t and using this union in the
> > > fs/afs/dir.c.
> > 
> > What compiler are you using, this is building fine with the gcc's I
> > have. Is it 2.95 ?
> 
> It doesn't compile with 2.95.4 from debian's 2.95.4-12. It does compile
> with gcc-3.x, where unnamed struct/union members seem to be introduced.

Makes sense then. Applied

