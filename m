Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTFYRqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbTFYRqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:46:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:15865 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264889AbTFYRqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:46:23 -0400
Subject: Re: [Must-fix] Keyboard occasionally endlessly repeating keys
From: john stultz <johnstul@us.ibm.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030625090723.GA10864@wohnheim.fh-wedel.de>
References: <20030620202444.GD22732@wohnheim.fh-wedel.de>
	 <1056495483.1027.260.camel@w-jstultz2.beaverton.ibm.com>
	 <20030625090723.GA10864@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1056563557.1033.278.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Jun 2003 10:52:37 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 02:07, Jörn Engel wrote:
> On Tue, 24 June 2003 15:58:04 -0700, john stultz wrote:
> > Assuming you're still seeing this, does booting w/ "clock=pit" resolve
> > the problem? If so could you send me more info about the system? (is
> > speed step enabled, etc?)
> 
> Problem appears to be from hardware, Vojtech Pavlik helped me a bit to
> track it down.  Hardware occasionally doesn't send the key release
> signal after a key pressed signel.
> 
> System is IBM Thinkpad R30, CPU permanently running on low speed
> (700MHz), no speed step (unsupported chipset).
> 
> Should I still test w/ clock=pit?

Not if its resolved for you. I was just seeing a number of time related
keyboard problems on laptops (kbd repeat rates too fast)and wanted to
see if you were affected as well. 

thanks
-john


