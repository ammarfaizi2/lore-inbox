Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWBTN3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWBTN3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWBTN3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:29:17 -0500
Received: from mx0.towertech.it ([213.215.222.73]:2195 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1030219AbWBTN3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:29:15 -0500
Date: Mon, 20 Feb 2006 14:22:58 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Vrabel <dvrabel@cantab.net>, Adrian Bunk <bunk@stusta.de>,
       Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Bowler <jbowler@acm.org>
Subject: Re: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values:
 maclist
Message-ID: <20060220142258.7299170c@inspiron>
In-Reply-To: <20060220130203.GA22147@flint.arm.linux.org.uk>
References: <20060220010113.GA19309@deprecation.cyrius.com>
	<20060220014735.GD4971@stusta.de>
	<20060220030146.11f418dc@inspiron>
	<43F9B32B.3090203@cantab.net>
	<20060220135718.038b675b@inspiron>
	<20060220130203.GA22147@flint.arm.linux.org.uk>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2006 13:02:03 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> >  for this driver which we are working on.. for example,
> >  some Cirrus Logic ARM based chips (ep93xx) have an ethernet device
> >  that could benefit from that.
> 
> An alternative solution (suggested in the past) would be to have a
> generic kernel command line option such as: mac=<netdev>,<macaddr>
> 
> It nicely solves the "no mac address" issue in a lot (if not all)
> of the cases.

 That would help, but it can't easily be implemented when you are
 targeting consumer devices like nas, routers et al which already
 have been widely deployed.

 I know that the solution would be to fix the bootloader, but
 Joe Average is a little bit scared of reflashing it.

 A maclist-alike system could help to solve that situation.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

