Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTIHNoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTIHNoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:44:12 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:47746 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262460AbTIHNmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:42:00 -0400
Subject: Re: [CFT][PATCH] new scheduler policy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Haoqiang Zheng <hzheng@cs.columbia.edu>,
       Nick Piggin <piggin@cyberone.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Mike Galbraith <efault@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030902142552.GG1358@openzaurus.ucw.cz>
References: <3F4182FD.3040900@cyberone.com.au>
	 <5.2.1.1.2.20030819113225.019dae48@pop.gmx.net>
	 <20030820021351.GE4306@holomorphy.com> <3F4A1386.9090505@cs.columbia.edu>
	 <3F4A172F.8080303@cyberone.com.au> <3F4A272F.8000602@cs.columbia.edu>
	 <20030902142552.GG1358@openzaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063028436.21084.30.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 14:40:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-02 at 15:25, Pavel Machek wrote:
> > in the best position to decide which process is more important. 
> > That's why I proposed kernel based approach.
> 
> Tasks can easily report their interactivity needs/nice value.
> X are already depend on clients not trying to screw each other,
> so thats okay.

There is a slight problem with a kernel based approach too - the app may
be remote. 

Alan

