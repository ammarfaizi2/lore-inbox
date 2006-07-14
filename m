Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422757AbWGNUeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWGNUeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbWGNUeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:34:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28934 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161292AbWGNUeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:34:19 -0400
Date: Fri, 14 Jul 2006 20:33:04 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, tglx@timesys.com,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] Rt-tester makes freezing processes fail.
Message-ID: <20060714203304.GB8731@ucw.cz>
References: <200607140918.49040.nigel@suspend2.net> <20060713163743.e71975b0.akpm@osdl.org> <200607141017.27832.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607141017.27832.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I yesterday queued up the below patch.  Which approach is most appropriate?
> 
> I prefer the one that makes these threads freeze (ie. the Luca's patch).

Agreed. We definitely do not want unneccessary stuff to run during
suspend.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
