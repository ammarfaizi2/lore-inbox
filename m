Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313093AbSC2CG0>; Thu, 28 Mar 2002 21:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313140AbSC2CGQ>; Thu, 28 Mar 2002 21:06:16 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:29153 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S313093AbSC2CGD>;
	Thu, 28 Mar 2002 21:06:03 -0500
Date: Fri, 29 Mar 2002 13:05:04 +1100
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203281443500.17304-100000@whisper.jaggnet.org> <200203282315.AAA02844@jagor.srce.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Message-Id: <1017367504.319988.13334.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 01:14:47AM +0100, Danijel Schiavuzzi wrote:

> > 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
> > 81) 00:01.0 
> 
> It's interesting that everyone who is experiencing these problems has the 
> *revision 81* of the VT8365 chipset! This should be the key...

You know, we might be barking down the wrong tree.  (Arf.)

So far, everybody who has reported video corruption seems to have
a Savage or ProSavage video card.  Maybe it'd be a better idea to
look at the ProSavage data sheets and see if we should be
tweaking something there?  That would be much safer than playing
around with the northbridges.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
