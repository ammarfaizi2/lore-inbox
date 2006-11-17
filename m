Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424419AbWKQCy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424419AbWKQCy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 21:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424752AbWKQCy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 21:54:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424419AbWKQCy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 21:54:26 -0500
Date: Thu, 16 Nov 2006 21:52:53 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [patch 05/30] splice: fix problem introduced with inode diet
Message-ID: <20061117025253.GT3983@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
	Jens Axboe <jens.axboe@oracle.com>
References: <20061116024332.124753000@sous-sol.org> <20061116024450.158521000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116024450.158521000@sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 06:43:37PM -0800, Chris Wright wrote:
 > -stable review patch.  If anyone has any objections, please let us know.
 > ------------------
 > 
 > From: Jens Axboe <jens.axboe@oracle.com>
 > 
 > After the inode slimming patch that unionised i_pipe/i_bdev/i_cdev, it's
 > no longer enough to check for existance of ->i_pipe to verify that this
 > is a pipe.
 > 
 > Original patch from Eric Dumazet <dada1@cosmosbay.com>
 > Final solution suggested by Linus.

2.6.18 didn't have the inode-diet patches.

[sidenote for the interested: they were in the Fedora 2.6.18 kernel, but I
 picked this patch up already there]

		Dave

-- 
http://www.codemonkey.org.uk
