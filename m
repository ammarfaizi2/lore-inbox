Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbSJWKgR>; Wed, 23 Oct 2002 06:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264619AbSJWKgR>; Wed, 23 Oct 2002 06:36:17 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:12505 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S264618AbSJWKgQ>; Wed, 23 Oct 2002 06:36:16 -0400
Date: Wed, 23 Oct 2002 12:42:13 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Marek <linux@hazard.jcu.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [miniPATCH] 2.5.44 fix compilation errors in the AFS fs
Message-ID: <20021023104213.GB3512@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jan Marek <linux@hazard.jcu.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021023095601.GB12175@hazard.jcu.cz> <1035368896.3968.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035368896.3968.31.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:28:16AM +0100, Alan Cox wrote:
> On Wed, 2002-10-23 at 10:56, Jan Marek wrote:
> > The first of them fixed union afs_dirent_t and using this union in the
> > fs/afs/dir.c.
> 
> What compiler are you using, this is building fine with the gcc's I
> have. Is it 2.95 ?

It doesn't compile with 2.95.4 from debian's 2.95.4-12. It does compile
with gcc-3.x, where unnamed struct/union members seem to be introduced.

-alex
