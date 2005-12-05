Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVLEVjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVLEVjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVLEVjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:39:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:16833 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964795AbVLEVjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:39:16 -0500
Subject: Re: ntp problems
From: john stultz <johnstul@us.ibm.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512050031.39438.gene.heskett@verizon.net>
References: <200512050031.39438.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 13:39:13 -0800
Message-Id: <1133818753.7605.47.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 00:31 -0500, Gene Heskett wrote:
> Greetings everybody;
> 
> I seem to have an ntp problem.  I noticed a few minutes ago that if
> my watch was anywhere near correct, then the computer was about 6
> minutes fast.  Doing a service ntpd restart crash set it back nearly
> 6 minutes.

Not sure exactly what is going on, but you might want to try dropping
the LOCAL server reference in your ntp.conf. It could be you're just
syncing w/ yourself.

thanks
-john

