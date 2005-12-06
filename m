Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbVLFAO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbVLFAO3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbVLFAO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:14:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:55994 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751510AbVLFAO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:14:28 -0500
Subject: Re: ntp problems
From: john stultz <johnstul@us.ibm.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512051833.19629.gene.heskett@verizon.net>
References: <200512050031.39438.gene.heskett@verizon.net>
	 <1133818753.7605.47.camel@cog.beaverton.ibm.com>
	 <200512051833.19629.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 16:14:25 -0800
Message-Id: <1133828065.7605.50.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 18:33 -0500, Gene Heskett wrote:
> On Monday 05 December 2005 16:39, john stultz wrote:
> >On Mon, 2005-12-05 at 00:31 -0500, Gene Heskett wrote:
> >> Greetings everybody;
> >>
> >> I seem to have an ntp problem.  I noticed a few minutes ago that if
> >> my watch was anywhere near correct, then the computer was about 6
> >> minutes fast.  Doing a service ntpd restart crash set it back nearly
> >> 6 minutes.
> >
> >Not sure exactly what is going on, but you might want to try dropping
> >the LOCAL server reference in your ntp.conf. It could be you're just
> >syncing w/ yourself.
> >
> Joanne, bless her, pointed out that I had probably turned the ACPI
> stuff in my kernel back on.  She was of course correct, shut it off &
> ntpd works just fine.

Err. ACPI stuff? Could you elaborate? Sounds like you have some sort of
bug hiding there. 

thanks
-john

