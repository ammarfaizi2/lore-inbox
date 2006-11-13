Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754714AbWKMOw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbWKMOw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbWKMOw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:52:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47593 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754714AbWKMOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:52:57 -0500
Subject: Re: What processor type?
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Stephen.Clark@seclark.us, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4558854A.2080902@rtr.ca>
References: <4557534E.9040205@seclark.us>
	 <1163363865.15249.32.camel@laptopd505.fenrus.org> <4558854A.2080902@rtr.ca>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 15:52:54 +0100
Message-Id: <1163429574.15249.149.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 09:46 -0500, Mark Lord wrote:
> Arjan van de Ven wrote:
> > On Sun, 2006-11-12 at 12:01 -0500, Stephen Clark wrote:
> >> Hello List,
> >>
> >> Could someone tell me what processor type I should select during kernel 
> >> config for
> >> an Intel Core 2 Duo T5600 chip.
> > 
> > the x86-64 "generic" option works best:
> 
> For 32-bit kernels, I suppose it should be one of Pentium-M or Pentium-4.

Pentium-M. Pentium-4 is an entirely different microarchitecture that
needs different optimizations than the Core 2 Duo; the pentium M
optimizations will work well on a Core 2 Duo... (although to be fair,
the Core 2 Duo runs just about all code you throw at it really really
fast anyway)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

