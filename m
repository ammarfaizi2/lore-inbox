Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266822AbTGGGfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbTGGGfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:35:07 -0400
Received: from dp.samba.org ([66.70.73.150]:21156 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266822AbTGGGfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 02:35:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16137.5916.301568.82746@cargo.ozlabs.ibm.com>
Date: Mon, 7 Jul 2003 16:45:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4.22-pre3] fix PPC32 compile failure due to
	SPRN_HID2 being undefined
In-Reply-To: <1057557063.503.108.camel@gaston>
References: <200307062243.h66MheGM023893@harpo.it.uu.se>
	<1057557063.503.108.camel@gaston>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> > SPRN_HID2 should be a #defined constant, but it isn't. The patch
> > below from 2.4.21-ben2 (rediffed for 2.4.22-pre3) fixes the problem.
> 
> Yup, Marcelo, please apply.

Um, I have that in the for-marcelo-ppc tree already, which I hope
Marcelo will pull before pre4.

Paul.
