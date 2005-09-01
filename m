Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVIAPXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVIAPXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVIAPXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:23:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63507
	"EHLO g5.random") by vger.kernel.org with ESMTP id S1030199AbVIAPXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:23:51 -0400
Date: Thu, 1 Sep 2005 17:23:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Sven Ladegast <sven@linux4geeks.de>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050901152344.GH1614@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830145602.GN8515@g5.random> <20050831182050.GC703@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831182050.GC703@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 08:20:51PM +0200, Pavel Machek wrote:
> Well, you could remove everything that is not valid kernel text from backtrace.

What if the corruption wrote the ssh key inside a the kernel text?

As suggested before, I suspect the only way would be to make it
optional.

> Oh and you probably want to somehow identify modified kernels.
> Otherwise if I do some development on 2.3.4-foo5, you'll get many oopsen
> caused by my development code... it is getting complex.

Agreed, however there's no way to do it reliably, since if you apply a
patch before compiling the kernel, there's no way to know it unless we
do a md5sum of the whole source at every compilation and that would be
too slow ;)

Thanks.
