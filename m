Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVF2Hj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVF2Hj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVF2Hhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:37:43 -0400
Received: from main.gmane.org ([80.91.229.2]:31447 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262473AbVF2Hd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:33:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
Date: Wed, 29 Jun 2005 09:32:20 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.29.07.32.18.523132@smurf.noris.de>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi> <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi> <20050628163114.6594e1e1.akpm@osdl.org> <1120018821.9658.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pekka Enberg wrote:

> The rationale for this is that since NULL is not guaranteed to be zero
> by the C standard

... as opposed to the other 632719 places in the kernel source where
we do the exact same thing?

If Linux ever gets ported to an architecture where NULL is not
all-bits-zero, the resulting patch will be so damn huge that the
cleanliness-or-not of freevxfs will be the *least* of our worries.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You'd best be snoozin', 'cause you don't be gettin' no work done at 5 a.m.
anyway.
		-- From the wall of the Wurster Hall stairwell


