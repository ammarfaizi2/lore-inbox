Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUIWPiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUIWPiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUIWPiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:38:22 -0400
Received: from ozlabs.org ([203.10.76.45]:50151 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266304AbUIWPiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:38:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16722.60814.732208.93234@cargo.ozlabs.ibm.com>
Date: Thu, 23 Sep 2004 08:36:46 -0700
From: Paul Mackerras <paulus@samba.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, anton@samba.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [PPC64] [TRIVIAL] Janitor whitespace in pSeries_pci.c
In-Reply-To: <20040922231700.GE30109@MAIL.13thfloor.at>
References: <20040920221933.GB1872@austin.ibm.com>
	<20040920223121.GC1872@austin.ibm.com>
	<200409211407.09764.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040921161216.GD1872@austin.ibm.com>
	<20040922231700.GE30109@MAIL.13thfloor.at>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl writes:

> well, I'd like to know if full whitespace cleanup
> (trailing and indentation) _is_ something which
> is interesting for linux mainline ...

It's like this... you get to clean up the white space in a file (if
you want) IF you are also doing some useful work on the file - but the
whitespace cleanup and the useful work need to be separate patches in
order to ease later tracking of what changed.

Paul.
