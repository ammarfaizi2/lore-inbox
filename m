Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUD0HC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUD0HC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 03:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUD0HC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 03:02:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:55517 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263851AbUD0HCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 03:02:55 -0400
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040426131152.GN2595@openzaurus.ucw.cz>
References: <1080310299.2108.10.camel@atari.stigge.org>
	 <20040326142617.GA291@elf.ucw.cz>
	 <1080315725.2951.10.camel@atari.stigge.org>
	 <20040326155315.GD291@elf.ucw.cz>
	 <1080317555.12244.5.camel@atari.stigge.org>
	 <20040326161717.GE291@elf.ucw.cz>
	 <1080325072.2112.89.camel@atari.stigge.org>
	 <20040426094834.GA4901@gondor.apana.org.au>
	 <20040426104015.GA5772@gondor.apana.org.au>
	 <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>
	 <20040426131152.GN2595@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1083048985.12517.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 16:56:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> re nuanced test? Better still, 
> 
> Test should still be there. Switching to temporary page tables
> seems to be tbe solution.

This is close to the problem I talked about when that PPC version
appeared, which is why, at least on resume, I run everything with
MMU off in the patch I proposed :)

(BTW, Nigel, did you merge the PPC support at all in swsusp2 ?)

Ben.


