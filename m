Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266042AbUFDWyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUFDWyW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUFDWyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:54:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:60821 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266042AbUFDWyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:54:03 -0400
Date: Sat, 5 Jun 2004 00:50:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: webvenza@libero.it
Cc: Nigel Kukard <nkukard@lbsd.net>, linux-kernel@vger.kernel.org
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Message-ID: <20040605005033.A26051@electric-eye.fr.zoreil.com>
References: <40C0E37C.4030905@lbsd.net> <20040604214721.GC22679@picchio.gall.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040604214721.GC22679@picchio.gall.it>; from webvenza@libero.it on Fri, Jun 04, 2004 at 11:47:21PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano <webvenza@libero.it> :
[...]
> > When using 2.4.x all is ok with hyperthreading enabled.
> This is important. The driver has some differences between the two
> versions, but none of them is releated to SMP. I'll chack again, but if
> someone with some more smp-karma than me wants to join, he is most
> welcome...

I have not checked the latest version of the driver but 2.6.7-rc2 seems
to give a Rx ring descriptor to the asic just before the Rx buffer
address is set. One would expect a different crash though.

--
Ueimor
