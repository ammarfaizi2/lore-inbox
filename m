Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272038AbTGYMFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272039AbTGYMFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:05:07 -0400
Received: from dsl027-161-083.atl1.dsl.speakeasy.net ([216.27.161.83]:48138
	"EHLO hoist") by vger.kernel.org with ESMTP id S272038AbTGYMFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:05:04 -0400
Date: Fri, 25 Jul 2003 08:20:08 -0400
To: "Michel Eyckmans (MCE)" <mce@pi.be>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC
Message-ID: <20030725122008.GA11362@suburbanjihad.net>
References: <816FF467B0D@vcnet.vc.cvut.cz> <200307242217.h6OMHPFk002164@jebril.pi.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307242217.h6OMHPFk002164@jebril.pi.be>
User-Agent: Mutt/1.3.28i
From: nick black <dank@suburbanjihad.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michel Eyckmans (MCE) assumed the extended riemann hypothesis and showed:
> >  Anyway, can you try applying matroxfb-2.5.72.gz from 
> > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest to your tree (you can
> > enable only matroxfb after patching, no other fbdev will work) and retry
> > tests?
> 
> YES! No more ghost X image, no more white rectangles, no more sudden 
> jump scrolling, and a backspace key that actually works again.

indeed, this patch also fixes all strange behavior i was seeing when
applied to 2.6.0-test1-ac3 yesterday; i haven't noticed a problem yet.
james, if you have time to pull the old behavior apart and push patches
for testing that may have been missed, i've got two cards that are fixed
by this patch.

-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo
