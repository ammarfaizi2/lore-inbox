Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbULBSfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbULBSfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbULBSfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:35:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:50603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbULBSfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:35:08 -0500
Date: Thu, 2 Dec 2004 10:33:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Grant Grundler <iod00d@hp.com>
Cc: jgarzik@pobox.com, torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041202103347.68b08352.akpm@osdl.org>
In-Reply-To: <20041202182716.GE25359@esmail.cup.hp.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	<41AEB44D.2040805@pobox.com>
	<20041201223441.3820fbc0.akpm@osdl.org>
	<20041202182716.GE25359@esmail.cup.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler <iod00d@hp.com> wrote:
>
> 2.6.odd/.even release described above is a variant of 2.6.10.n releases
>  where n = {0, 1}. The question is how many parallel releases do people
>  (you and linus) want us keep "alive" at the same time?

2.6.odd/.even is actually a significantly different process.  a) because
there's only one tree, linearly growing.  That's considerably simpler than
maintaining a branch.  And b) because everyone knows that there won't be a
new development tree opened until we've all knuckled down and fixed the
bugs which we put into the previous one, dammit.

