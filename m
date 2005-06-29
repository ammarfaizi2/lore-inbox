Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVF2HnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVF2HnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVF2Hkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:40:40 -0400
Received: from main.gmane.org ([80.91.229.2]:18907 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262481AbVF2HkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:40:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
Date: Wed, 29 Jun 2005 09:39:30 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.29.07.38.40.275982@smurf.noris.de>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi> <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi> <20050628163114.6594e1e1.akpm@osdl.org> <20050629070729.GB16850@infradead.org> <20050629001717.65fb272c.akpm@osdl.org> <20050629072115.GA17261@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph Hellwig wrote:

> On Wed, Jun 29, 2005 at 12:17:17AM -0700, Andrew Morton wrote:
>> Come to think of it, it could be a problem if the comnpiler was silly and
>> built an entire temporary on the stack and the copied it over.  Hopefull it
>> won't do that.
> 
> that patch is fine except for the second to last patch which should be
> droped.

If you do that, you also need to drop the third-to-last patch ...

Personally, I think struct assignments are fine if the compiler
does them right. As this example shows, at least they avoid the
I-forgot-to-zero-the-struct problem. ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
First Rule of History:
	History doesn't repeat itself -- historians merely repeat each other.


