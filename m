Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270250AbTGMQFz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270251AbTGMQFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:05:55 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:43268
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S270250AbTGMQFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:05:51 -0400
Subject: Re: 2.5.75-mm1: lockup when inserting USB storage device
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030713042422.GF2695@kroah.com>
References: <1058050082.4831.70.camel@ixodes.goop.org>
	 <20030713042422.GF2695@kroah.com>
Content-Type: text/plain
Message-Id: <1058113235.4997.3.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Jul 2003 09:20:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 21:24, Greg KH wrote:
> Most people get the suspend/resume cycle to work properly for USB by
> unloading and then loading the host controller drivers.  Does that solve
> this problem?
> 
> Yeah, I know it's not a perfect solution, sorry.  Hopefully we will get
> better power management stuff soon...

Thanks, I'll try that out.

What about the 2nd part of the problem, in which the USB storage device
is detected but unusable after insertion?

Thanks,
	J

