Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTLJSQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTLJSQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:16:55 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:23180 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263812AbTLJSQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:16:53 -0500
Date: Wed, 10 Dec 2003 18:08:49 +0000
From: Dave Jones <davej@redhat.com>
To: Chris Petersen <Chris.Petersen@synopsys.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FIXED (was Re: PROBLEM:  Blk Dev Cache causing kswapd thrashing)
Message-ID: <20031210180849.GA13303@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Petersen <Chris.Petersen@synopsys.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311271649520.21568-100000@logos.cnet> <3FD75B8A.21FA59D9@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD75B8A.21FA59D9@synopsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 12:44:42PM -0500, Chris Petersen wrote:

 > It appears the block-device-cache/kswapd problem is indeed fixed in
 > 2.4.23 (yay!).
 > 
 > To confuse matters RedHat has released an RPM with 2.4.20-24.7 which
 > apparently contains later patches that include the fix.

2.4.20-24.7 contains two patches. Both security issues. (do_brk
and an nptl local DoS), nothing else (vs previous 2.4.20-20.7)
 
 > This can be
 > confusing because their 2.4.21-4EL kernel is busted (WRT this bug)

That kernel bears no relation whatsoever to 2.4.20-24.7
It's for a completely different product for one thing, with
very little in common between them (in terms of patches we add).

		Dave

