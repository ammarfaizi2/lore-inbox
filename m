Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUKCBAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUKCBAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUKCA75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:59:57 -0500
Received: from c-24-10-162-127.client.comcast.net ([24.10.162.127]:49792 "EHLO
	zedd.willden.org") by vger.kernel.org with ESMTP id S261175AbUKCA6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:58:02 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8 Thinkpad T40, clock running too fast
Date: Tue, 2 Nov 2004 17:58:12 -0700
User-Agent: KMail/1.7
Cc: john stultz <johnstul@us.ibm.com>
References: <200411021551.53253.shawn-lkml@willden.org> <200411021703.43453.shawn-lkml@willden.org> <1099441631.9139.36.camel@cog.beaverton.ibm.com>
In-Reply-To: <1099441631.9139.36.camel@cog.beaverton.ibm.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021758.16313.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 02 November 2004 05:27 pm, john stultz wrote:
> Not really, the problem is that the sleep call returns after so many
> timer ticks, so even if the wrong amount of time has passed, you'll see
> the same number of interrupts.

Ah, right.  Nothing like measuring a ruler with itself.

> It would be best if you checked the time 
> on your watch, waited 5 minutes and checked again, or better, did
> something similar w/ ntpdate.  I just wanted to eyeball it to make sure
> you weren't running away w/ way too many timer interrupts.

I'll do that

> PS: If you wouldn't mind, CC me next time.

I am.  BTW, in case you didn't see my other e-mail, I'm now running with 2.6.9 
and cpufreq off.  No significant change.

 Shawn.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBiC0o6d8WxFy/CWcRAv2RAJ9ZhrXkIAoiEpZ9PrFK+jAQLMKyhQCfXkai
YhtDAgHFdjIR+WpV3XdG5Ss=
=kO2+
-----END PGP SIGNATURE-----
