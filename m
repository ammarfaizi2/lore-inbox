Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVDFBVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVDFBVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 21:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVDFBVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 21:21:20 -0400
Received: from pat.uio.no ([129.240.130.16]:36557 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262045AbVDFBVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 21:21:15 -0400
Subject: Re: [RFC] Add support for semaphore-like structure with support
	for asynchronous I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
In-Reply-To: <20050405154641.GA27279@kvack.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
	 <20050330143409.04f48431.akpm@osdl.org>
	 <1112224663.18019.39.camel@lade.trondhjem.org>
	 <1112309586.27458.19.camel@lade.trondhjem.org>
	 <20050331161350.0dc7d376.akpm@osdl.org>
	 <1112318537.11284.10.camel@lade.trondhjem.org>
	 <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com>
	 <20050404162216.GA18469@kvack.org>
	 <1112637395.10602.95.camel@lade.trondhjem.org>
	 <20050405154641.GA27279@kvack.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 21:20:57 -0400
Message-Id: <1112750457.14586.53.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.794, required 12,
	autolearn=disabled, AWL 1.21, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 05.04.2005 Klokka 11:46 (-0400) skreiv Benjamin LaHaise:

> I can see that goal, but I don't think introducing iosems is the right 
> way to acheive it.  Instead (and I'll start tackling this), how about 
> factoring out the existing semaphore implementations to use a common 
> lib/semaphore.c, much like lib/rwsem.c?  The iosems can be used as a 
> basis for the implementation, but we can avoid having to do a giant 
> s/semaphore/iosem/g over the kernel tree.

If you're willing to take this on then you have my full support and I'd
be happy to lend a hand.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

