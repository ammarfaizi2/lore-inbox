Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVDKSNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVDKSNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVDKSNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:13:42 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:49349 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261426AbVDKSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:13:40 -0400
Date: Mon, 11 Apr 2005 11:13:19 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Jackson <pj@engr.sgi.com>, pasky@ucw.cz,
       rddunlap@osdl.org, ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-ID: <20050411181319.GA11302@taniwha.stupidest.org>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu> <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu> <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org> <20050411153905.GA7284@elte.hu> <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 09:01:51AM -0700, Linus Torvalds wrote:

> I disagree. Yes, the thing is designed to be replicated, so most of
> the time the easiest thing to do is to just rsync with another copy.

It's not clear how any of this is going to give me something like

     bk changes -R

or
     bk changes -L

functionality.  I'm guessing I will have to sync locally and check
between two trees in those cases?  Or at least sync enough metadata as
to make this possible...  but not the entire tree right?
