Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTFITzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTFITzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:55:21 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:60424 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261168AbTFITzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:55:05 -0400
Subject: Re: 2.5.70-mm6
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <51250000.1055184690@flay>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	 <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
	 <46580000.1055180345@flay>
	 <Pine.LNX.4.51.0306092017390.25458@dns.toxicfilms.tv>
	 <51250000.1055184690@flay>
Content-Type: text/plain
Message-Id: <1055189322.600.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 09 Jun 2003 22:08:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 20:51, Martin J. Bligh wrote:
> >> If you don't nice the hell out of X, does it work OK?
> > No.
> > 
> > The way I reproduce the sound skips:
> > run xmms, run evolution, compose a mail with gpg.
> > on mm6 the gpg part stops the sound for a few seconds. (with X -10 and 0)
> > on mm5 xmms plays without stops. (with X -10)
> 
> Does this (from Ingo?) do anything useful to it?

I can confirm that 2.5.70-mm6 with Ingo's patch and HZ set back to 1000
is nearly perfect (it still takes some seconds for the scheduler to
adjust dynamic priorities).

