Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWIOIW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWIOIW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWIOIW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:22:26 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:24562 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750725AbWIOIWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:22:25 -0400
Date: Fri, 15 Sep 2006 10:22:32 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch 3/4] AVR32 MTD: Mapping driver for theATSTK1000board
Message-ID: <20060915102232.29909340@cad-250-152.norway.atmel.com>
In-Reply-To: <1158307230.24527.36.camel@pmac.infradead.org>
References: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
	<20060914163026.49766346@cad-250-152.norway.atmel.com>
	<20060914163121.241dec3e@cad-250-152.norway.atmel.com>
	<20060914163259.068abe6d@cad-250-152.norway.atmel.com>
	<1158264688.4312.82.camel@pmac.infradead.org>
	<20060915095629.22cf01f4@cad-250-152.norway.atmel.com>
	<1158307230.24527.36.camel@pmac.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 09:00:30 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> I'm coming to the conclusion that if there are flash chips which
> inherit the Intel insanity of automatically locking themselves on
> every power cycle, thus rendering the 'locked' status meaningless, we
> should just automatically unlock the whole chip at boot time, from
> the _chip_ driver.

Yeah, there really is no reason to keep anything "soft locked". I'll
unlock the chip from the fixup I submitted earlier so that it comes up
unlocked by default.

> So it's trapped for moderation and I
> get to look at it and manually approve it.

I'll keep doing it, then. That way, I can be sure that you'll notice my
patches, too ;)

Thanks,

Haavard
