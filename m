Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTD1StZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTD1StZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:49:25 -0400
Received: from dp.samba.org ([66.70.73.150]:48867 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261243AbTD1StY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:49:24 -0400
Date: Tue, 29 Apr 2003 04:57:41 +1000
From: Anton Blanchard <anton@samba.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428185741.GA14391@krispykreme>
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com> <3EAD5D90.7010101@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAD5D90.7010101@gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Cool. Sorry to be pestering about the 64-bit limits, but can we really
> use 2^64 bytes of memory on ia64/ppc64/x86-64 etc.? (AFAIK, 64-bit
> arches don't suffer from a small ZONE_LOWMEM.)

For ppc64 our current maximum is 2TB and so far the biggest machine we
have tested on is 512GB.

Anton
