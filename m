Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992606AbWJTMT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992606AbWJTMT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992607AbWJTMT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:19:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:50133 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2992606AbWJTMT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:19:27 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: 2.6.19-rc2-mm1 unwinder issues ?
Date: Fri, 20 Oct 2006 14:19:17 +0200
User-Agent: KMail/1.9.3
Cc: "Badari Pulavarty" <pbadari@us.ibm.com>, akpm@osdl.org,
       "lkml" <linux-kernel@vger.kernel.org>
References: <1161210966.18117.33.camel@dyn9047017100.beaverton.ibm.com> <4538C07F.76E4.0078.0@novell.com>
In-Reply-To: <4538C07F.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610201419.17702.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> must be reverted for things to work again. Andi, what did you
> want to cure with it? Clearly, when rSP isn't the CFA register
> anymore, there must not (normally) be adjustments to the
> CFA offset. Similarly, when a register was saved already and
> it's not its spill location that changes, it must not be marked
> as being saved a second time.

Hmm, it was supposed to fix one report, but probably i did something
wrong. Ok I'll revert it.

Thanks

-Andi
