Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTIYSoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTIYSoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:44:03 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:56974 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261823AbTIYSnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:43:15 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030925.200135.607960881.rene.rebe@gmx.net>
References: <1063221565.678.2.camel@gaston>
	 <20030910.222620.730549923.rene.rebe@gmx.net>
	 <1063262157.2023.19.camel@gaston>
	 <20030925.200135.607960881.rene.rebe@gmx.net>
Message-Id: <1064515390.19697.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 20:43:11 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: dmasound_pmac (2.4.x{,-benh}) does not restore mixer during
	PM-wake
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-25 at 20:01, Rene Rebe wrote:
> Hi,
> 
> On: Thu, 11 Sep 2003 08:35:57 +0200,
>     Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > so hm?!? - is the wakeup order of the devices incorrect (i2c needs to
> > > be before damsound_pmac ...)?
> > 
> > The i2c bus isn't suspended during sleep... I don't know for sure
> > what's up, I'll investigate.
> 
> Have you found some time to look into this issue in more detail? I
> already tried a tiny timeout wihtout help - maybe you got an idea?

My current bk 2.4 contains a reworked i2c driver that might help...

Ben.


