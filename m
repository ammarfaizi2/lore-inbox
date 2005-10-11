Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbVJKKuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVJKKuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 06:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJKKuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 06:50:44 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:56521 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751396AbVJKKun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 06:50:43 -0400
Subject: Re: ide_wait_not_busy oops still with 2.6.14-rc3 (Re: 1GHz pbook
	15", linux 2.6.14-rc2 oops on resume)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1129026986.17365.206.camel@gaston>
References: <1128323544.4602.5.camel@localhost>
	 <pan.2005.10.06.19.19.22.673915@nn7.de>  <1128720351.17365.48.camel@gaston>
	 <1128948118.23434.13.camel@localhost>  <1128982002.17365.163.camel@gaston>
	 <1129026807.21318.15.camel@localhost>  <1129026986.17365.206.camel@gaston>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 12:50:33 +0200
Message-Id: <1129027834.21318.25.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 20:36 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2005-10-11 at 12:33 +0200, Soeren Sonnenburg wrote:
> > On Tue, 2005-10-11 at 08:06 +1000, Benjamin Herrenschmidt wrote:
> > > > ok, here is the complete one:
[...]
> > Hmmhh, I already compiled 2.6.14-rc4 but did not disable
> > soft-lockup-ing, should I still do it - the oops looks better as it is
> > not followed by a ATAPI reset anymore:
> 
> It's still pretty annoying. I'll see what I can do but it won't be for
> 2.6.14 timeframe, so in the meantime, just ignore it or remove soft
> lockup detection.

OK, it is a minor issue anyway as one needs a cd/dvd in the drive (on
resume) to trigger that.

Thanks
Soeren.
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

