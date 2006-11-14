Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754822AbWKNLO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbWKNLO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755259AbWKNLO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:14:58 -0500
Received: from raven.upol.cz ([158.194.120.4]:51131 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1754822AbWKNLO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:14:58 -0500
Date: Tue, 14 Nov 2006 11:21:52 +0000
To: Martin Braun <mbraun@uni-hd.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: xfs kernel BUG again in 2.6.17.11
Message-ID: <20061114112152.GA11492@flower.upol.cz>
References: <44E1D9CA.30805@uni-hd.de> <20060816101122.E2740551@wobbly.melbourne.sgi.com> <44EB228F.6020903@uni-hd.de> <20060823134211.E2968256@wobbly.melbourne.sgi.com> <45583ABE.6080909@uni-hd.de> <20061114040053.GD8394166@melbourne.sgi.com> <45598B07.6080401@uni-hd.de> <slrnelj5k3.7lr.olecom@flower.upol.cz> <45599B0E.8050505@uni-hd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45599B0E.8050505@uni-hd.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 11:31:42AM +0100, Martin Braun wrote:
> Hi Oleg,
> 
> thanks for your response.
> > You can find fixes in .17 stable git tree.
> Yes it is a 2.6.17.11 stable kernel. - By the way: we tried to setup
> kernel 2.6.18.2 on that machine but we got a weired time error, ntpdate

2.6.18 have many XFS fixes, that were not backported to 2.6.17
(and will not, i think).

> shows two times: first run correct time, second run time is half an hour
> in the future - so we switched back to 2.6.17.11
 
(And not mixing too much here, try to search last 3 months for "ntp".
 There are people, who can actually help with that. 2.6.19-rc have even
 more timekeeping fixes, maybe something will work for you).
____
