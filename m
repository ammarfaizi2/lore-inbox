Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTGGSTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 14:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTGGSTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 14:19:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37066 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264219AbTGGSSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 14:18:55 -0400
Date: Mon, 7 Jul 2003 15:30:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4.22-pre3] fix PPC32 compile failure due to SPRN_HID2
 being undefined
In-Reply-To: <16137.5916.301568.82746@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.55L.0307071530200.8259@freak.distro.conectiva>
References: <200307062243.h66MheGM023893@harpo.it.uu.se> <1057557063.503.108.camel@gaston>
 <16137.5916.301568.82746@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jul 2003, Paul Mackerras wrote:

> Benjamin Herrenschmidt writes:
>
> > > SPRN_HID2 should be a #defined constant, but it isn't. The patch
> > > below from 2.4.21-ben2 (rediffed for 2.4.22-pre3) fixes the problem.
> >
> > Yup, Marcelo, please apply.
>
> Um, I have that in the for-marcelo-ppc tree already, which I hope
> Marcelo will pull before pre4.

Just pushed it and pulled to bkbits.net
