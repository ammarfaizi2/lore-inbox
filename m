Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbTFEV6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbTFEV6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:58:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57530 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265208AbTFEV6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:58:16 -0400
Date: Thu, 5 Jun 2003 15:12:44 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Greg KH <greg@kroah.com>, Hanna Linder <hannal@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
In-Reply-To: <20030605220716.GF608@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306051511350.13077-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Okay, that means that another patch is needed to create hierarchy for
> power managment... This sysfs stuff is getting hairy.

No it's not. The hierarchy is the device tree, which is the original 
purpose of it, remember? 

keyboards and mice should be created as platform devices as they are 
probed and discovered by i8042 driver. It's not hairy, just not done yet. 


	-pat

