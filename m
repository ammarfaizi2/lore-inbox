Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264803AbTFESXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264807AbTFESXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:23:34 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30477
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264803AbTFESXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:23:33 -0400
Date: Thu, 5 Jun 2003 11:37:02 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Vladimir Saveliev <vs@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       reiserfs-dev@namesys.com
Subject: Re: file write performance drop between 2.5.60 and 2.5.70
Message-ID: <20030605183702.GC3291@matchmail.com>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	Vladimir Saveliev <vs@namesys.com>,
	LKML <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com
References: <200306042017.53435.vs@namesys.com> <1054749758.699.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054749758.699.5.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 08:02:39PM +0200, Felipe Alfaro Solana wrote:
> On Wed, 2003-06-04 at 18:17, Vladimir Saveliev wrote:
> > Hi
> > 
> > It looks like file write performance dropped somewhere between 2.5.60 and 
> > 2.5.70.
> > Doing
> > time dd if=/dev/zero of=file bs=4096 count=60000
> > 
> > on a box with Xeon(TM) CPU 2.40GHz and 1gb of RAM
> > I get for ext2
> > 2.5.60: 	real	1.42 sys 0.77
> > 2.5.70: 	real 1.73 sys 1.23
> > for reiserfs
> > 2.5.60: 	real 1.62 sys 1.56
> > 2.5.70: 	real 1.90 sys 1.86
> > 
> > Any ideas of what could cause this drop?
> 
> What filesystem are you using?

Good one.

ext2 and reiserfs.

Read the origional message again.
