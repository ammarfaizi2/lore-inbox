Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUDNS2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbUDNS2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:28:46 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:24221 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263800AbUDNS2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:28:44 -0400
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>
References: <403C014F.2040504@blue-labs.org>
	 <1077674048.10393.369.camel@cube> <403C2E56.2060503@blue-labs.org>
	 <1077679677.10393.431.camel@cube>  <403CCD3A.7080200@mvista.com>
	 <1077725042.8084.482.camel@cube>  <403D0F63.3050101@mvista.com>
	 <1077760348.2857.129.camel@cog.beaverton.ibm.com>
	 <403E7BEE.9040203@mvista.com>
	 <1077837016.2857.171.camel@cog.beaverton.ibm.com>
	 <403E8D5B.9040707@mvista.com>
	 <1081895880.4705.57.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1081967295.4705.96.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Apr 2004 11:28:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 05:10, Tim Schmielau wrote:
> Excuse me for barging in lately and innocently, but I find this patch
> hard to comprehend:
>  - shouldn't a foo_to_clock_t() function return a clock?
>  - the x = seems superfluous
>  - the #if is not a shortcut anymore, so why keep it?
> Shouldn't this patch be more like the following
> (completely untested)?

Yes, you're cleanups look much better! Although we still have yet to
hear if it resolves the problem. 

thanks
-john

