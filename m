Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTLIJ6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTLIJ6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:58:16 -0500
Received: from AGrenoble-101-1-3-30.w193-253.abo.wanadoo.fr ([193.253.251.30]:29669
	"EHLO awak") by vger.kernel.org with ESMTP id S264288AbTLIJ4R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:56:17 -0500
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Greg KH <greg@kroah.com>
Cc: Witukind <witukind@nsbm.kicks-ass.org>, recbo@nishanet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031209090815.GA2681@kroah.com>
References: <200312081536.26022.andrew@walrond.org>
	 <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com>
	 <20031208233755.GC31370@kroah.com>
	 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
	 <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade>
	 <20031209090815.GA2681@kroah.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1070963757.869.86.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 10:55:58 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 09/12/2003 à 10:08, Greg KH a écrit :
> > That's something I don't understand: I thought that with a well
> > configured hotplug+udev system, you'll never have to worry about loading
> > drivers on device-node open() because all drivers should be auto-loaded
> > and all device-nodes should be auto-created.
> > 
> > Am I wrong ?
> 
> No, you are correct.  That's why I'm not really worried about this, and
> I don't think anyone else should be either.

So to attenuate people's worries it should be stated in some form:

A:	Such a functionality isn't needed on a properly configured
	system. All devices present on the system should generate
	hotplug events, loading the appropriate driver, and udev
	should notice and create the appropriate device node.
	In case of failure, please make a proper bug report.

Of course, you'll have to translate it to correct english.

	Xav

