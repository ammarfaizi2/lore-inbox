Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162379AbWKQGQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162379AbWKQGQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162380AbWKQGQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:16:20 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42683 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162379AbWKQGQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:16:19 -0500
Date: Thu, 16 Nov 2006 22:16:32 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [stable] [patch 05/30] splice: fix problem introduced with inode diet
Message-ID: <20061117061632.GK1397@sequoia.sous-sol.org>
References: <20061116024332.124753000@sous-sol.org> <20061116024450.158521000@sous-sol.org> <20061117025253.GT3983@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117025253.GT3983@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> On Wed, Nov 15, 2006 at 06:43:37PM -0800, Chris Wright wrote:
>  > -stable review patch.  If anyone has any objections, please let us know.
>  > ------------------
>  > 
>  > From: Jens Axboe <jens.axboe@oracle.com>
>  > 
>  > After the inode slimming patch that unionised i_pipe/i_bdev/i_cdev, it's
>  > no longer enough to check for existance of ->i_pipe to verify that this
>  > is a pipe.
>  > 
>  > Original patch from Eric Dumazet <dada1@cosmosbay.com>
>  > Final solution suggested by Linus.
> 
> 2.6.18 didn't have the inode-diet patches.

Thanks, you're right, this is needless churn.  Dropping.
-chris
