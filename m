Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTELRSX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTELRSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:18:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:53004 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262348AbTELRSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:18:22 -0400
Date: Mon, 12 May 2003 19:25:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>, marcelo@conectiva.com.br
Cc: Willy Tarreau <willy@w.ods.org>, gibbs@scsiguy.com,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030512172547.GA15233@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030509145738.GB17581@alpha.home.local> <20030512110218.4bbc1afe.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512110218.4bbc1afe.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Mon, May 12, 2003 at 11:02:18AM +0200, Stephan von Krawczynski wrote:

> I have tried 2.4.21-rc2 with aic79xx-linux-2.4-20030502-tar.gz for three days
> now and have to say it performs well. I had no freezes any more and nothing
> weird happening. Everything is smooth and ok. This is the best performance I
> have seen comparing all 2.4.21-X versions tested.

Same here, it seems rock solid on my dual athlon and has survived several
hours of 5 simultaneous make -j 8 bzImage modules with swapping. Definitely the
most stable for me since I've switched from Doug's to Justin's driver.

Marcelo, would it be unreasonable to include it in -rc3 ? After all, it would
not be a radical update, since it was removed from -rc2 ? Just a few bug fixes.

What do you think ?

Regards,
Willy

