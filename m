Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWKMSdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWKMSdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbWKMSdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:33:24 -0500
Received: from khc.piap.pl ([195.187.100.11]:58089 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1755302AbWKMSdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:33:23 -0500
To: Paul Fulghum <paulkf@microgate.com>
Cc: Jeff Garzik <jeff@garzik.org>,
       Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de>
	<4558860B.8090908@garzik.org> <45588895.7010501@microgate.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 13 Nov 2006 19:33:18 +0100
In-Reply-To: <45588895.7010501@microgate.com> (Paul Fulghum's message of "Mon, 13 Nov 2006 09:00:37 -0600")
Message-ID: <m3ejs78adt.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> writes:

> synclink drivers can *optionally* support generic hdlc.
> You *must* be able to build synclink driver without generic hdlc.
> Because of this you *can't* just put in the generic hdlc dependency.
>
> Several alternative patches were posted (3 or 4 months) ago.
> No particular patch won the approval of all kernel developers,
> so nothing was done.

I remember something actually did "won the approval". Don't remember
the details but I think it included conditional compilation, not
changing CONFIG_* macros (using different name(s) instead, just not
starting with "CONFIG_"), and IIRC no changes to Kconfigs.

At least I don't remember any objections to that last version so
I assumed it's closed.

Perhaps it was just a dream, who knows :-)

Nevertheless a fix outlined above would be acceptable, wouldn't it?
-- 
Krzysztof Halasa
