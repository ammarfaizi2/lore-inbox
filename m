Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVFVM5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFVM5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 08:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVFVM5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 08:57:34 -0400
Received: from main.gmane.org ([80.91.229.2]:25285 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261255AbVFVM5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 08:57:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Date: Wed, 22 Jun 2005 14:57:08 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.22.12.57.02.20384@smurf.noris.de>
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pavel Machek wrote:

> How is it going
> to interact with backup tools?

I admit to severe dislike for any backup tool which crosses file system
borders without permission, and therefore am not going to cry if something
breaks because of this.

Ditto updatedb/locate -- it's a remote file system. Tools should
treat it as such.

NB: I am assuming that root can stat() the mountpoint and that it's not
possible to delay this call arbitrarily. If not, the debate IMHO should be
whether to special-case this situation.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The early worm has a death wish.


