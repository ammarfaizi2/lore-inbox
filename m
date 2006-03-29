Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWC2If7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWC2If7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 03:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWC2If7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 03:35:59 -0500
Received: from mail.charite.de ([160.45.207.131]:27798 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1750718AbWC2If6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 03:35:58 -0500
Date: Wed, 29 Mar 2006 10:35:54 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060329083554.GB5438@charite.de>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de> <20060327080811.D753448@wobbly.melbourne.sgi.com> <20060326230358.GG4776@charite.de> <20060327060436.GC2481@frodo> <20060327110342.GX21946@charite.de> <20060328050135.GA2177@frodo> <20060328112859.GA3851@charite.de> <20060329074333.E871924@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060329074333.E871924@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Scott <nathans@sgi.com>:
> On Tue, Mar 28, 2006 at 01:28:59PM +0200, Ralf Hildebrandt wrote:
> > * Nathan Scott <nathans@sgi.com>:
> > 
> > > OK, I think I see whats gone wrong here now.  Ralf, could you try
> > > the patch below and check that it fixes your test case?
> > 
> > The patch is against what? -git12? 2.6.16?
> 
> Should apply cleanly to the current git tree (did yesterday, anyway).

Alas, it fixes the problem (in -mm2, that is). Thanks!

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
