Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274351AbRITG6a>; Thu, 20 Sep 2001 02:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274352AbRITG6K>; Thu, 20 Sep 2001 02:58:10 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:44050 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S274351AbRITG55>; Thu, 20 Sep 2001 02:57:57 -0400
Date: Thu, 20 Sep 2001 16:57:46 +1000
From: john slee <indigoid@higherplane.net>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Liakakis Kostas <kostas@skiathos.physics.auth.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010920165746.G16408@higherplane.net>
In-Reply-To: <3E975341CB7@vcnet.vc.cvut.cz> <Pine.LNX.4.33.0109200105300.25500-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109200105300.25500-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 01:07:29AM +0200, Luigi Genoni wrote:
> Just to add a curiosity. Abit KT7A MBs do not accept all 256 MB modules.
> with some of them they do see just 128 MB, and anyway systems are stable,
> but of course systems managers get unhappy.
> This should be because of modules density...

bx chipsets have a limitation of 128mb per bank for non-registered dimms
afaik.  ie. 256mb dimms that are two-bank will work as expected, and
256mb dimms that are one-bank will be seen as 128mb.  generally two-bank
256mb dimms have chips on both sides of the module, whereas one-bank
jobbies have it on one side...  found this out the expensive way :-(

of course this isnt relevant to abit kt7 boards but it does sound very
similar.

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
