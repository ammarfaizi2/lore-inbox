Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269361AbUJLADP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269361AbUJLADP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269364AbUJLADP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:03:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:41621 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269361AbUJLADL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:03:11 -0400
Subject: Re: 2.6.9-rc4-mm1 OOPs on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041011234625.GA17340@wotan.suse.de>
References: <1097527401.12861.383.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011214304.GD31731@wotan.suse.de>
	 <1097532118.12861.395.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011221519.GA11702@wotan.suse.de>
	 <20041011153830.495b7c2d.akpm@osdl.org>
	 <1097536210.12861.402.camel@dyn318077bld.beaverton.ibm.com>
	 <20041011234625.GA17340@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1097538827.12861.414.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Oct 2004 16:53:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> rc3-mm3/4 should work when you revert the optimize-profi... patch or boot
> with profile=2 - i normally don't test -mm* myself, but some users
> reported that.
> 
> But I'm not sure anybody tested it on a 4way. 

Well. Here is what I know, so far ..

2.6.9-rc4-mm1 doesn't boot (Bad Page flags)
2.6.9-rc3-mm3 doesn't boot (same issue)
2.6.9-rc3-mm2 works fine.

I don't run anything other than -mm tree for 2.6 :)
I will dig some more tomorrow on whats breaking it.

I am having a bad day today - AMD64 doesn't boot. PPC64 doesn't boot.
I can't test Manfred's alloc_node patch :(

Thanks,
Badari

