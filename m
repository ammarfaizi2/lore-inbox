Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbTJBOvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTJBOvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:51:06 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:9446 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263352AbTJBOvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:51:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16252.15182.516051.237181@gargle.gargle.HOWL>
Date: Thu, 2 Oct 2003 16:50:54 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Jonathan Brown <jbrown@emergence.uk.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: What Processor family for Centrino Pentium M?
In-Reply-To: <3F7C373D.7070409@stesmi.com>
References: <1065032627.9643.57.camel@localhost>
	<16251.10643.891947.130552@gargle.gargle.HOWL>
	<3F7C373D.7070409@stesmi.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski writes:
 > Hi Mikael.
 > 
 > >  > Is the Pentium M a P3 or a P4? What should I set in my kernel config?
 > > 
 > > Pentium III.
 > 
 > Isn't it based on the P4 ? It uses the same quad pumped bus at the P4
 > and has SSE2 for instance. Both of those are lacking on the P3.

While it has some P4-like extensions, the P-M core is P6 not NetBurst.
This is trivially deducible from various Intel documents, including
the P-M spec update, the IA32 Volume3 manual, and the Code Optim manual.
Also, CPUID reports family 6 not 15.
