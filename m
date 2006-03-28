Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWC1L3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWC1L3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWC1L3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:29:09 -0500
Received: from mail.charite.de ([160.45.207.131]:32933 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932186AbWC1L3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:29:06 -0500
Date: Tue, 28 Mar 2006 13:28:59 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060328112859.GA3851@charite.de>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de> <20060327080811.D753448@wobbly.melbourne.sgi.com> <20060326230358.GG4776@charite.de> <20060327060436.GC2481@frodo> <20060327110342.GX21946@charite.de> <20060328050135.GA2177@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060328050135.GA2177@frodo>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Scott <nathans@sgi.com>:

> OK, I think I see whats gone wrong here now.  Ralf, could you try
> the patch below and check that it fixes your test case?

The patch is against what? -git12? 2.6.16?

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
