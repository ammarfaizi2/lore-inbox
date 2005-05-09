Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVEITBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVEITBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEITBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:01:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:8606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261501AbVEITBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:01:34 -0400
Date: Mon, 9 May 2005 12:01:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: Chris Friesen <cfriesen@nortel.com>, James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any work in implementing Secure IPC for Linux?
Message-ID: <20050509190115.GA23013@shell0.pdx.osdl.net>
References: <Xine.LNX.4.44.0505091058560.5582-100000@thoron.boston.redhat.com> <200505091940.22260.ks@linnovative.dk> <427FA3D4.1080706@nortel.com> <200505092044.29440.ks@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505092044.29440.ks@cs.aau.dk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kristian S?rensen (ks@cs.aau.dk) wrote:
> On Monday 09 May 2005 19:54, Chris Friesen wrote:
> > How about unix sockets?
> > 	--you can have sockets in the filesystem namespace with regular file
> > permissions to control who is allowed to send messages to particular
> > addresses
> This is the same problem: Basing access control on user and group is not 
> enough - especially as the root-user can overrule any access control 
> specified by the normal DAC file attributes.

If you want the application involved/aware, you can still use finer
grained credentials, have a look at getpeersec.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
