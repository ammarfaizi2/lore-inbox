Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbTEMNpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTEMNpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:45:09 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:34954 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261202AbTEMNpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:45:08 -0400
Date: Tue, 13 May 2003 14:57:56 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513135756.GA676@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <shswugvjcy9.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shswugvjcy9.fsf@charged.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:36:14PM +0200, Trond Myklebust wrote:
 >      > - davej: NFS seems to have a really bad time for some people.  (Including
 >      >   myself on one testbox).  The common factor seems to be a high
 >      >   spec client torturing an underpowered NFS server with lots of
 >      >   IO.  (fsx/fsstress etc show this up).  Lots of "NFS server
 >      >   cheating" messages get dumped, and a whole lot of bogus
 >      >   packets start appearing.  They look severely corrupted, (they
 >      >   even crashed ethereal once 8-)
 > 
 > Could people please test these items out again using the latest
 > Bitkeeper release? I believe I've addressed all these issues with the
 > patches that have gone to Linus in the last 2-3 weeks.

I can still kill an NFS server in under a minute with fsx.

		Dave

