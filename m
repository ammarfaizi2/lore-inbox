Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUHSTPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUHSTPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUHSTPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:15:41 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:61063 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S267287AbUHSTPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:15:38 -0400
Date: Thu, 19 Aug 2004 22:15:37 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       george anzinger <george@mvista.com>, Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
Message-ID: <20040819191537.GA24060@elektroni.ee.tut.fi>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	john stultz <johnstul@us.ibm.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	george anzinger <george@mvista.com>,
	Andrew Morton OSDL <akpm@osdl.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
	nicolas.george@ens.fr, david+powerix@blue-labs.org
References: <87smcf5zx7.fsf@devron.myhome.or.jp> <20040816124136.27646d14.akpm@osdl.org> <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de> <412285A5.9080003@mvista.com> <1092782243.2429.254.camel@cog.beaverton.ibm.com> <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de> <1092787863.2429.311.camel@cog.beaverton.ibm.com> <1092781172.2301.1654.camel@cube> <1092791363.2429.319.camel@cog.beaverton.ibm.com> <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 09:42:17AM +0200, Tim Schmielau wrote:
> Updated patch below. It's not very well tested, but it compiles, boots, 
> and fixes the problem on i386 with the default HZ=1000 and USER_HZ=100.

Yes, it works nicely now.
