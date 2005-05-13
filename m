Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVEMXne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVEMXne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVEMXnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:43:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17631 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262601AbVEMXmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:42:15 -0400
Date: Fri, 13 May 2005 19:42:11 -0400
From: Dave Jones <davej@redhat.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 MTRR handling
Message-ID: <20050513234211.GF13846@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <42852CE2.4090102@zytor.com> <20050513232357.GB13846@redhat.com> <428539EA.7000406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428539EA.7000406@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 04:36:10PM -0700, H. Peter Anvin wrote:

 > The Efficeon (TM8xxx) series does have PAT.

1:1 with the Intel implementation I assume based on your earlier comments?

 > > > >+ * Note: On Athlon cpus PAT2/PAT3 & PAT6/PAT7 are both Uncacheable 
 > > since > >+ *	 there is no uncached type.
 > > > If one sets the PAT to "uncached", does one get the same function as 
 > > > "uncachable"?
 > >
 > >AIUI, only as long as we don't have an MTRR covering the same range marked 
 > >WC.
 > >It seems to be the only thing I could find documenting the differences
 > >between 'uncached' and 'uncacheable' in this context.
 > >Though I've only looked through the Intel & AMD K8 docs, I don't have
 > >the K7 ones to hand.
 > >
 > 
 > I mean, on the Athlon series, is it really necessary to use a different 
 > value?

I'd have to dig out the docs and check.

		Dave
