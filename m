Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSFYSoM>; Tue, 25 Jun 2002 14:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSFYSoL>; Tue, 25 Jun 2002 14:44:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9628 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S314514AbSFYSoK>;
	Tue, 25 Jun 2002 14:44:10 -0400
Date: Tue, 25 Jun 2002 11:38:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: driverfs is not for everything! (was: [PATCH] /proc/scsi/map )
In-Reply-To: <200206241809.g5OI9Ds02886@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0206251136570.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think the qualification for appearing in driverfs is actually possessing a 
> driver.  Therefore, we accept FC and iSCSI.  Things which appear as 
> FileSystems are debatable, but not anything which has a real device driver.

The qualification for appearing in the device tree is the physical 
presence of the device, regardless of the presence of a driver to control 
it. (This typically depends on the presence of the bus driver so it can 
discover the device.) Presence in the device tree implies presence in 
driverfs.

	-pat

