Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbTFETK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTFETK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:10:58 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:60167 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264909AbTFETK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:10:57 -0400
Subject: Re: file write performance drop between 2.5.60 and 2.5.70
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030605183702.GC3291@matchmail.com>
References: <200306042017.53435.vs@namesys.com>
	 <1054749758.699.5.camel@teapot.felipe-alfaro.com>
	 <20030605183702.GC3291@matchmail.com>
Content-Type: text/plain
Message-Id: <1054841055.585.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 05 Jun 2003 21:24:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 20:37, Mike Fedyk wrote:
> On Wed, Jun 04, 2003 at 08:02:39PM +0200, Felipe Alfaro Solana wrote:
> > On Wed, 2003-06-04 at 18:17, Vladimir Saveliev wrote:
> > > Hi
> > > 
> > > It looks like file write performance dropped somewhere between 2.5.60 and 
> > > 2.5.70.
> > > Doing
> > > time dd if=/dev/zero of=file bs=4096 count=60000
> > > 
> > > on a box with Xeon(TM) CPU 2.40GHz and 1gb of RAM
> > > I get for ext2
> > > 2.5.60: 	real	1.42 sys 0.77
> > > 2.5.70: 	real 1.73 sys 1.23
> > > for reiserfs
> > > 2.5.60: 	real 1.62 sys 1.56
> > > 2.5.70: 	real 1.90 sys 1.86
> > > 
> > > Any ideas of what could cause this drop?
> > 
> > What filesystem are you using?
> 
> Good one.
> 
> ext2 and reiserfs.
> 
> Read the origional message again.

Hmmm... What filesystem was being used?
Arghh!!! I'm blind!!!!!!!

