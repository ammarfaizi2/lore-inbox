Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTLKLFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 06:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbTLKLFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 06:05:36 -0500
Received: from AGrenoble-101-1-4-17.w217-128.abo.wanadoo.fr ([217.128.202.17]:55693
	"EHLO awak") by vger.kernel.org with ESMTP id S264881AbTLKLFf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 06:05:35 -0500
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
From: Xavier Bestel <xavier.bestel@free.fr>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xk753hd90.fsf@kth.se>
References: <1070963757.869.86.camel@nomade>
	 <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
	 <20031209183001.GA9496@kroah.com> <yw1xvfop257d.fsf@kth.se>
	 <1071039765.1790.94.camel@nomade>
	 <20031210210614.625ccfcc.witukind@nsbm.kicks-ass.org>
	 <1071134837.1789.123.camel@nomade>  <yw1xk753hd90.fsf@kth.se>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1071140719.869.139.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 12:05:19 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 11/12/2003 à 11:15, Måns Rullgård a écrit :
> I was objecting to the udev
> way of thinking that all drivers are always loaded.  If you want to
> use udev and on-demand loading, you need to do some tweaking.

Technically it's hotplug which assumes that all drivers are always to be
loaded. But you are right.
And even there, I'd say hotplug+udev has the advantage: being userland
scripts, they can be tweaked to meet your needs (like on-demand loading
only your floppy, in your case). Unlike devfs.
Mechanism, not policy, etc.

	Xav

