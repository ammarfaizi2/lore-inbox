Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTEMPev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTEMPev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:34:51 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:3728 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261727AbTEMPet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:34:49 -0400
Date: Tue, 13 May 2003 16:47:41 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513154741.GA4511@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <shswugvjcy9.fsf@charged.uio.no> <20030513135756.GA676@suse.de> <16065.3159.768256.81302@charged.uio.no> <20030513152228.GA4388@suse.de> <16065.4109.129542.777460@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16065.4109.129542.777460@charged.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:32:29PM +0200, Trond Myklebust wrote:

 > That is a server bug. There are no rules for congestion control
 > etc. in the NFS or SunRPC protocols, so the server is supposed to be
 > able to cope with whatever the client manages to throw at it.
 > 
 > I presume, though, that you are not seeing the 2.4.x NFS server die in
 > this way when you blast it with a 2.5 client?

I had thought that the 2.4 server survived this. I just did a test
with a 2.4.21pre7 kernel and found the same behaviour, so this isn't
a regression, just something thats not very nice.

		Dave

