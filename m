Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935600AbWK1FTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935600AbWK1FTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 00:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935603AbWK1FTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 00:19:32 -0500
Received: from main.gmane.org ([80.91.229.2]:31109 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S935600AbWK1FTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 00:19:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: Entropy Pool Contents
Date: Mon, 27 Nov 2006 21:19:20 -0800
Message-ID: <878xhw5esn.fsf@blp.benpfaff.org>
References: <ek2nva$vgk$1@sea.gmane.org> <456B4CD2.7090208@cfl.rr.com>
	<ekfifg$n41$1@taverner.cs.berkeley.edu>
	<EB3E5F09-6529-4AB9-B7EF-DFCACC6D445E@mac.com>
	<ekgd7u$6gp$1@taverner.cs.berkeley.edu>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-7-50-23.hsd1.ca.comcast.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:ELZZN2Ru0oqApHM2hffXOpx5AoE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daw@cs.berkeley.edu (David Wagner) writes:

> Well, if you want to talk about really high-value keys like the scenarios
> you mention, you probably shouldn't be using /dev/random, either; you
> should be using a hardware security module with a built-in FIPS certified
> hardware random number source.  

Is there such a thing?  "Annex C: Approved Random Number
Generators for FIPS PUB 140-2, Security Requirements for
Cryptographic Modules", or at least the version of it I was able
to find with Google in a few seconds, simply states:

        There are no FIPS Approved nondeterministic random number
        generators.
-- 
"Welcome to the Slippery Slope. Here is your handbasket.
 Say, can you work 70 hours this week?"
--Ron Mansolino

