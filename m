Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTFJJm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTFJJm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:42:58 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11017 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262569AbTFJJm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:42:57 -0400
Subject: Re: 2.5.70-mm6
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <64000000.1055189666@flay>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	 <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
	 <46580000.1055180345@flay>
	 <Pine.LNX.4.51.0306092017390.25458@dns.toxicfilms.tv>
	 <51250000.1055184690@flay>
	 <1055189322.600.1.camel@teapot.felipe-alfaro.com>
	 <64000000.1055189666@flay>
Content-Type: text/plain
Message-Id: <1055238993.586.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 10 Jun 2003 11:56:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 22:14, Martin J. Bligh wrote:
> --On Monday, June 09, 2003 22:08:42 +0200 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> 
> > On Mon, 2003-06-09 at 20:51, Martin J. Bligh wrote:
> >> >> If you don't nice the hell out of X, does it work OK?
> >> > No.
> >> > 
> >> > The way I reproduce the sound skips:
> >> > run xmms, run evolution, compose a mail with gpg.
> >> > on mm6 the gpg part stops the sound for a few seconds. (with X -10 and 0)
> >> > on mm5 xmms plays without stops. (with X -10)
> >> 
> >> Does this (from Ingo?) do anything useful to it?
> > 
> > I can confirm that 2.5.70-mm6 with Ingo's patch and HZ set back to 1000
> > is nearly perfect (it still takes some seconds for the scheduler to
> > adjust dynamic priorities).
> 
> OK ... sorry to be pedantic, but I want to nail this down.
> It's still broken with HZ=1000, but without Ingo's patch, right?

Well, Ingo's patch makes XMMS more resistant to audio skip when HZ=1000.
Anyways, with HZ=1000 interactivity is much better than with HZ=100
(with or without Ingo's patch).


