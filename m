Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbTEVXXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTEVXXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:23:12 -0400
Received: from palrel12.hp.com ([156.153.255.237]:6038 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263390AbTEVXXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:23:12 -0400
Date: Thu, 22 May 2003 16:36:09 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: irtty_sir cannot be unloaded
Message-ID: <20030522233609.GA11706@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stian Jordet wrote :
> 
> Module irtty_sir cannot be unloaded due to unsafe usage in
> include/linux/module.h:456
> 
> I get this message when trying to use irda with 2.5.x. I know it has
> been there for a long time, but since nothing happens

	This is fixed in the patches I've send to Jeff :
http://marc.theaimsgroup.com/?l=linux-kernel&m=105286597418927&w=2
	Just be patient ;-)

	I guess that if it's the only complain, this means that the
rest of the IrDA stack works for you in 2.5.X. At least, I'm not the
only one testing it...

	Jean
