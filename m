Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUHUA56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUHUA56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 20:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268785AbUHUA56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 20:57:58 -0400
Received: from the-village.bc.nu ([81.2.110.252]:62857 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268717AbUHUA55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 20:57:57 -0400
Subject: Re: [RFC] enhanced version of net_random()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       Jean-Luc Cooke <jlcooke@certainkey.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
       netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1093037055.10063.192.camel@krustophenia.net>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	 <20040820175952.GI5806@certainkey.com>
	 <20040820185956.GV8967@schnapps.adilger.int>
	 <1093037055.10063.192.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093046100.31904.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 21 Aug 2004 00:55:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 22:24, Lee Revell wrote:
> One problem is that AIUI, we incur this overhead even if a hardware RNG
> is present.  This does not seem right.  Hardware RNGs are increasingly
> common, Linux supports hardware RNGs from AMD, Intel, and VIA.

Hardware RNG's are actually fairly slow and thus are better as sources
to perturb a PRNG.

