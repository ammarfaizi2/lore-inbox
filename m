Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310661AbSCHCz0>; Thu, 7 Mar 2002 21:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310660AbSCHCzR>; Thu, 7 Mar 2002 21:55:17 -0500
Received: from stargazer.compendium-tech.com ([64.156.208.76]:2489 "EHLO
	stargazer.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S310657AbSCHCzC>; Thu, 7 Mar 2002 21:55:02 -0500
Date: Thu, 7 Mar 2002 18:54:17 -0800 (PST)
From: Kelsey Hudson <khudson@compendium-tech.com>
To: Hank Yang <hanky@promise.com.tw>
cc: arjanv@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
In-Reply-To: <00b901c1c642$e7b6e9b0$59cca8c0@hank>
Message-ID: <Pine.LNX.4.44.0203071853260.16402-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Hank Yang wrote:

> Hello.
> 
>     That's because the linux-kernel misunderstand the raid controller
> to IDE controller. If do so, The raid driver will be unstable when
> be loaded.
> 
>     So we must to prevent the raio controller to be as IDE controller
> here.

There *are* some people who don't want to use the raid layer on the card 
and simply use it as an ide controller. besides, the software raid driver 
already takes care of raid volumes on this card

