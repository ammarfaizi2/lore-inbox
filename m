Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbVKCVMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbVKCVMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbVKCVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:12:46 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:50108 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030485AbVKCVMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:12:45 -0500
Date: Thu, 3 Nov 2005 16:12:43 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: Jean-Christian de Rivaz <jc@eclis.ch>, linux-kernel@vger.kernel.org,
       dean@arctic.org
Subject: Re: NTP broken with 2.6.14
Message-ID: <20051103211243.GU9486@csclub.uwaterloo.ca>
References: <43694DD1.3020908@eclis.ch> <1130976935.27168.512.camel@cog.beaverton.ibm.com> <43695D94.10901@eclis.ch> <1130980031.27168.527.camel@cog.beaverton.ibm.com> <43697550.7030400@eclis.ch> <1131046348.27168.537.camel@cog.beaverton.ibm.com> <20051103195124.GE9488@csclub.uwaterloo.ca> <1131048670.27168.573.camel@cog.beaverton.ibm.com> <20051103204807.GT9486@csclub.uwaterloo.ca> <1131051627.27168.590.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131051627.27168.590.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 01:00:27PM -0800, john stultz wrote:
> You could try disabling NTP and running the python script I sent out
> earlier in this thread to determine your systems ppm drift. Outside
> +/-500ppm is def broken, outside of +/-250ppm is probably broken,
> outside +/-100ppm isn't great but correctable and inside +/-100ppm is
> (unfortunately) pretty average for most hardware.

Well with no ntpd running on 2.6.14, it appears that my nforce2 board
matches that bug rather well.  About a second gained every minute or
two.

> Ok, do you want to open your own bug on this and we'll mark them
> duplicate as needed?
> 
> Please attach dmesg output to the bug as well.

Well it seems whatever was wrong with 2.6.12 for me, isnt' a problem in
2.6.14, as it is not gaining 10 to 15 seconds every minute now.  It is
still gaining a bit though.  I have no tried to run without the local
apic in case that makes a difference.

Len Sorensen
