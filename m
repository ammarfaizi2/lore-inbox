Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbUC2Kl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 05:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUC2Kl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 05:41:59 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:29312 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S262791AbUC2Kl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 05:41:58 -0500
Message-ID: <4067FD42.9030206@steudten.com>
Date: Mon, 29 Mar 2004 12:41:06 +0200
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
CC: linux-raid@vger.kernel.org, mingo@redhat.com, neilb@cse.unsw.edu.au
Subject: Re: md raid oops on 2.4.25/alpha
References: <20031027141358.GA26271@gamma.logic.tuwien.ac.at> <20040327164153.GA7324@gamma.logic.tuwien.ac.at> <20040328160246.GA19965@gamma.logic.tuwien.ac.at> <40670BAE.4060901@steudten.com> <20040328223013.A15859@jurassic.park.msu.ru>
In-Reply-To: <20040328223013.A15859@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know from my own system, that the oops in the raid1 sources, are
not the only point, where gcc generates wrong assembler code.
So it't better not to workaround just this single point, but
use the fixed gcc instead.

Ivan Kokshaysky wrote:

> Also, here is a hack (originally from Jay Estabrook) which
> should work around a bug in older compilers.

