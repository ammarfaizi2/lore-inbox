Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUCKDDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 22:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbUCKDDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 22:03:23 -0500
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:1920 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S262756AbUCKDDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 22:03:12 -0500
Date: Wed, 10 Mar 2004 19:00:36 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: James Morris <jmorris@redhat.com>
Cc: Clay Haapala <chaapala@cisco.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
Message-ID: <20040311030035.GA3782@jm.kir.nu>
References: <20040310053411.GB4346@jm.kir.nu> <Xine.LNX.4.44.0403101044480.30984-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0403101044480.30984-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 10:45:28AM -0500, James Morris wrote:

> On Tue, 9 Mar 2004, Jouni Malinen wrote:
> > Fixed. The included patch combines changesets for both the setkey
> > addition and Michael MIC. Please let me know if you want to get these as
> > separate patch files.
> 
> This is oopsing on 'modprobe tcrypt'.
> 
> Separate patches would be preferred.

I was unable to reproduce the oops by loading tcrypt. All tests passed
and the kernel was fine. I did this testing with Linux 2.6.4-rc3 and
all crypto algs compiled as modules. I will try this again with the
latest linus-2.5 BK tree just in case. Anyway, if you happen to have any
more details from the oops like backtrace or any ideas of what might be
causing the difference in our results, they would be very helpful.

I will also send separate patches once I figure out what caused the oops
with tcrypt.

-- 
Jouni Malinen                                            PGP id EFC895FA
