Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVKJAkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVKJAkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVKJAkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:40:39 -0500
Received: from main.gmane.org ([80.91.229.2]:41443 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751132AbVKJAki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:40:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [git patches] 2.6.x libata updates
Date: Thu, 10 Nov 2005 01:36:59 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.10.00.36.56.947377@smurf.noris.de>
References: <20051029182228.GA14495@havoc.gtf.org> <200510300644.20225.rob@landley.net> <Pine.LNX.4.64.0510301435520.27915@g5.osdl.org> <200510301731.47825.rob@landley.net> <Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Cc: linux-ide@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus Torvalds wrote:

> I have to say that the bk->cvs gateway is actually a very impressive 
> linearization, and I don't even know how it did it.

That's easy -- it found the longest path from A to B and generated patches
between each step.

Looking at the latest tree with gitk, I'd guess that the previous rate
of roughly 50% is no longer achievable; linearizing would aggregate
some large chunks of patch-series and subtree merges (no surprise there).

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Automobile, n.:
	A four-wheeled vehicle that runs up hills and down pedestrians.


