Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264174AbUESNh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUESNh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 09:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUESNh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 09:37:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:47597 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264174AbUESNh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 09:37:27 -0400
Subject: Re: 1352 NUL bytes at the end of a page?
From: Chris Mason <mason@suse.com>
To: Steven Cole <scole@lanl.gov>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, hugh@veritas.com,
       elenstev@mesatop.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       support@bitmover.com, Wayne Scott <wscott@bitmover.com>,
       adi@bitmover.com, akpm@osdl.org, wli@holomorphy.com,
       Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com
In-Reply-To: <70C69E3C-A998-11D8-A7EA-000A95CC3A8A@lanl.gov>
References: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>
	 <200405190453.31844.elenstev@mesatop.com>
	 <1084968622.27142.5.camel@watt.suse.com>
	 <20040519.072009.92566322.wscott@bitmover.com>
	 <40AB5639.7060806@yahoo.com.au>
	 <70C69E3C-A998-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Type: text/plain
Message-Id: <1084973802.27142.14.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 May 2004 09:36:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 09:28, Steven Cole wrote:

> > Steven, with all else being equal, you said you found a 2.6.3 SuSE
> > kernel to significantly outperform 2.6.6, is that right? If so can
> > you try the same test with plain 2.6.3 please? We'll go from there.
> 
> Actually, it was a Mandrake kernel, 2.6.3-4mdk IIRC.  Whatever is
> the default with MDK 10.  One salient difference with the vendor
> kernel is that everything which can be a module is, and I wasn't
> using any modules with my kernels.  BTW, I was careful to have the
> same hdparm settings during the performance testing.
> 
> The performance difference was very repeatable.  Using the script
> provided by Andy Isaacson, the 2.6.3-4mdk did the clone in about
> 11 minutes total, while the various current kernels took about
> 15 minutes total.  The user times were the same, and the difference
> was in system time.  Those numbers are from memory, the actual
> results should be in the archive.

Was this regression only reiserv3 or both v3 and ext3?

-chris


