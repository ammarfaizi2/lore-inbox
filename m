Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264790AbUE2NNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264790AbUE2NNz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUE2NNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:13:55 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:27268 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264790AbUE2NNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:13:46 -0400
Date: Sat, 29 May 2004 15:14:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040529131406.GB6185@ucw.cz>
References: <Pine.GSO.4.58.0405281654370.3992@stekt37>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405281654370.3992@stekt37>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 04:59:55PM +0300, Tuukka Toivonen wrote:
> Giuseppe Bilotta wrote:
> >The new system has some ups and downs. The biggest "down",
> >which is that of RAW mode not being available anymore (it's
> >emulated!) could be circumvented by having both the RAW and
> >translated codes move between layers.
> 
> Ouch! If the user asks for raw mode, he doesn't get it, but some emulated
> mode? To me this sounds like a big incompatibility.

Q1: What would you do if the user has an USB keyboard?

Q2: What application should be looking at the raw data outside the
    kernel and why?

> Fortunately this patch
> (written together with Sau Dan Lee) should give _really_ raw mode in 2.6.x
> too (but it's not compatible with the raw mode in 2.4.x):
> 
> http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.5-userdev.20040507.patch
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
