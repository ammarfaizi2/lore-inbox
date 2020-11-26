Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48032C56202
	for <io-uring@archiver.kernel.org>; Thu, 26 Nov 2020 04:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79F421741
	for <io-uring@archiver.kernel.org>; Thu, 26 Nov 2020 04:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgKZEaR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 25 Nov 2020 23:30:17 -0500
Received: from shells.gnugeneration.com ([66.240.222.126]:39334 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgKZEaQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 25 Nov 2020 23:30:16 -0500
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id B423E1A402DF; Wed, 25 Nov 2020 20:30:16 -0800 (PST)
Date:   Wed, 25 Nov 2020 20:30:16 -0800
From:   Vito Caputo <vcaputo@pengaru.com>
To:     io-uring@vger.kernel.org
Subject: LD_PRELOAD-able io_uring emulation library in userspace?
Message-ID: <20201126043016.3yb5ggpkgvuzhudw@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hello list,

Has anyone already produced a userspace implementation of io_uring
atop pthreads, for debugging purposes perhaps?

It seems like this would be useful for supporting pre-io_uring
kernels, even if the performance is worse than the real thing.  At
least it enables access to software written exclusively for the new
interface, even on old systems.

Also, at least until tools like strace learn about io_uring, it might
be a useful visibility aid.

Regards,
Vito Caputo
