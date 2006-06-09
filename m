Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWFITXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWFITXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWFITXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:23:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:40858 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030429AbWFITW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:22:59 -0400
Message-ID: <4489CA8E.1030507@garzik.org>
Date: Fri, 09 Jun 2006 15:22:54 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<m33beecntr.fsf@bzzz.home.net>	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>	<20060609181020.GB5964@schatzie.adilger.int>	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>	<m31wty9o77.fsf@bzzz.home.net>	<Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <m3vera6snv.fsf@bzzz.home.net>
In-Reply-To: <m3vera6snv.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> the main reason is that ext4 would be treated as a new generation
> fs which will be used for lots of new features probably. and it
> will take long to get into production-ready state. at the same
> time, proposed patches (at least extents itself) are heavily
> tested in production and could be made available for our users
> very soon.

No -- that's a bad way to develop it, and a good way to ensure it will 
never get stable.

You want to start from a known good point, and keep it working. 
Standard iterative development model.

	Jeff


