Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSFXShN>; Mon, 24 Jun 2002 14:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSFXShM>; Mon, 24 Jun 2002 14:37:12 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:51052 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S314783AbSFXShM>; Mon, 24 Jun 2002 14:37:12 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7F55@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'James Bottomley'" <James.Bottomley@steeleye.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: RE: driverfs is not for everything! (was: [PATCH] /proc/scsi/map 
	) 
Date: Mon, 24 Jun 2002 11:37:04 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: James Bottomley [mailto:James.Bottomley@steeleye.com] 
> andrew.grover@intel.com said:
> > If a device can be accessed by multiple machines concurrently, it
> > should not be in driverfs. 
> 
> On that argument, we'll eliminate almost all Fibre Channel devices!
> 
> I think the qualification for appearing in driverfs is 
> actually possessing a 
> driver.  Therefore, we accept FC and iSCSI.  Things which appear as 
> FileSystems are debatable, but not anything which has a real 
> device driver.

OK that makes sense.

Regards -- Andy
