Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUC1Uce (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbUC1Uce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:32:34 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:4615 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262459AbUC1Uca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:32:30 -0500
Date: Sun, 28 Mar 2004 22:32:10 +0200
To: Ross Dickson <ross@datscreative.com.au>,
       Thomas Steudten <alpha@steudten.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, mingo@redhat.com,
       neilb@cse.unsw.edu.au
Subject: Re: md raid oops on 2.4.25/alpha
Message-ID: <20040328203210.GD3633@gamma.logic.tuwien.ac.at>
References: <20031027141358.GA26271@gamma.logic.tuwien.ac.at> <20040327164153.GA7324@gamma.logic.tuwien.ac.at> <20040328160246.GA19965@gamma.logic.tuwien.ac.at> <40670BAE.4060901@steudten.com> <20040328223013.A15859@jurassic.park.msu.ru> <20031027141358.GA26271@gamma.logic.tuwien.ac.at> <20040327164153.GA7324@gamma.logic.tuwien.ac.at> <20040328160246.GA19965@gamma.logic.tuwien.ac.at> <40670BAE.4060901@steudten.com> <200403290245.51813.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040328115951.A30976@mail.harddata.com> <20040328223013.A15859@jurassic.park.msu.ru> <40670BAE.4060901@steudten.com> <200403290245.51813.ross@datscreative.com.au>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all for the quick answer ...

On Son, 28 Mär 2004, Ivan Kokshaysky wrote:
> Also, here is a hack (originally from Jay Estabrook) which
> should work around a bug in older compilers.

I used this diff and it is working now, at least I hope, tests are
coming.

Again, thanks again for the fast answer!

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HODNET (n.)
The wooden safety platform supported by scaffolding round a building
under construction from which the builders (at almost no personal
risk) can drop pieces of cement on passers-by.
			--- Douglas Adams, The Meaning of Liff
