Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946345AbWBDH7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946345AbWBDH7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946347AbWBDH7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:59:24 -0500
Received: from main.gmane.org ([80.91.229.2]:57490 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1946345AbWBDH7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:59:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: 2.6.16-rc1-mm5
Date: Sat, 04 Feb 2006 08:59:09 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.02.04.07.59.06.888460@smurf.noris.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:

> - If you hit a bug in -mm and it's not obvious which patch caused it, it
> is
>   most valuable if you can perform a bisection search to identify which
>   patch introduced the bug.  Instructions for this process are at
> 
>         http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

You can also use the mm->git tree (at .../linux/kernel/git/smurf/
/linux-trees.git) and use "git bisect".

It'll be a bit slower, but the upside is that it's able to descend into
the git trees which Andrew has imported into mm as monolithic patches.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I do not fear computers.  I fear the lack of them.
		-- Isaac Asimov


