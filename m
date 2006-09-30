Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422877AbWI3BpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422877AbWI3BpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 21:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWI3BpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 21:45:08 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:55265 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1422877AbWI3BpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 21:45:06 -0400
Date: Fri, 29 Sep 2006 18:40:43 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
Message-ID: <20060930014043.GA10927@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929182008.fee2a229.akpm@osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 06:20:08PM -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 20:01:54 -0400
> > 
> > A quick strace of gkrellm finds these likely ioctl's causing the problem:
> > 
> > % grep ioctl /tmp/foo2 | sort -u | more
> > ioctl(13, SIOCGIWESSID, 0xbfbcdb9c)     = 0
> > ioctl(13, SIOCGIWRANGE, 0xbfbcdbdc)     = 0
> > ioctl(13, SIOCGIWRATE, 0xbfbcdbbc)      = 0

	Excuse me, can you point out wich version of gkrellm you use
and where to find it, the only version that is listed on my page does
not use the ESSID ioctl. I want to be sure I'm looking at the same
thing as you are...

	Jean
