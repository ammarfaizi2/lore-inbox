Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVCGTAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVCGTAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVCGTAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:00:16 -0500
Received: from palrel10.hp.com ([156.153.255.245]:59867 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261184AbVCGTAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:00:09 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16940.42163.397058.311057@napali.hpl.hp.com>
Date: Mon, 7 Mar 2005 11:00:03 -0800
To: Jes Sorensen <jes@wildopensource.com>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch - 2.6.11-rc5-mm1] genalloc - general purpose allocator
In-Reply-To: <yq03bvdf8bf.fsf@jaguar.mkp.net>
References: <16934.4191.474769.320391@jaguar.mkp.net>
	<16934.5385.841758.628631@napali.hpl.hp.com>
	<yq03bvdf8bf.fsf@jaguar.mkp.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 03 Mar 2005 03:21:56 -0500, Jes Sorensen <jes@wildopensource.com> said:

  Jes> mempool on the other hand will first try and call the user
  Jes> provided allocation function and only if that fails try and
  Jes> take memory from the pool, this will force us to convert pages
  Jes> from cached to uncached if we don't have to.

Ah, that's a good point.

  Jes> [snip...]

  Jes> One could probably do this via mempool, but it would basically
  Jes> require one to put another object allocator below mempool which
  Jes> really makes the whole exercise pointless as this could just as
  Jes> well be done standalone ... ie. genalloc.

It does sound that way, yes.

Thanks,

	--david
