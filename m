Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVH3E7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVH3E7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVH3E7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:59:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:15890 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932132AbVH3E7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:59:32 -0400
Date: Tue, 30 Aug 2005 06:54:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ake <Ake.Sandgren@hpc2n.umu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.30-hf2
Message-ID: <20050830045416.GF10110@alpha.home.local>
References: <20050829082900.GB11312@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050829082900.GB11312@hpc2n.umu.se>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 10:29:00AM +0200, Ake wrote:
> I got the following Oops.
> Known problem? Fix?

Nothing known here. You can retry with -hf7 if you want, which fixes other
bugs, but I guess it will not change anything.

> The kernel is a plain 2.4.30-hf2

I have some question : what is /usr/opt/scali/kernel/scip/scip.o ? Isn't
it a binary module ? It does not seem to belong to the plain 2.4.30-hf2.

> EIP:    0010:[<f890e708>]    Tainted: PF
> Warning (expand_objects): object /usr/opt/scali/kernel/scip/scip.o for module scip has changed since load

Is this oops reproducible ? is it reproducible without any binary module ?

Willy
 
