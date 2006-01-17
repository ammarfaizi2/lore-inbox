Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWAQTLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWAQTLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWAQTLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:11:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:9954 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751300AbWAQTLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:11:54 -0500
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3
	oops on suspend and more (bonus oops shot!)]
From: john stultz <johnstul@us.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060117174953.GA3529@inferi.kami.home>
References: <20060111100016.GC2574@elf.ucw.cz>
	 <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org>
	 <20060111184027.GB4735@inferi.kami.home>
	 <20060112220825.GA3490@inferi.kami.home>
	 <1137108362.2890.141.camel@cog.beaverton.ibm.com>
	 <20060114120816.GA3554@inferi.kami.home>
	 <1137442582.27699.12.camel@cog.beaverton.ibm.com>
	 <20060116204057.GC3639@inferi.kami.home>
	 <1137458964.27699.65.camel@cog.beaverton.ibm.com>
	 <20060117174953.GA3529@inferi.kami.home>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 11:11:30 -0800
Message-Id: <1137525090.27699.92.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 18:49 +0100, Mattia Dongili wrote:
> On Mon, Jan 16, 2006 at 04:49:18PM -0800, john stultz wrote:
> > On Mon, 2006-01-16 at 21:40 +0100, Mattia Dongili wrote:
> > > On Mon, Jan 16, 2006 at 12:16:21PM -0800, john stultz wrote:
> > > > I'll try to narrow that window down a bit and see if that doesn't
> > > > resolve the issue.
> > > 
> > > I'll be happy to test new patches if necessary (I'm running -mm4)
> > 
> > See if this patch doesn't resolve the issue. Its a bit hackish, but
> > basically I'm just holding off installing any clocksources until later
> > on at boot. This avoids some of the clocksource churn.
> 
> With the patch applied the boot went smooth.

Great. Thanks for the testing. I'll send that one off to Andrew.

thanks again,
-john

