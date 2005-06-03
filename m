Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVFCQxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVFCQxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVFCQxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:53:24 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:48574 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261391AbVFCQxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:53:20 -0400
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new
	DellBIOS update driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Abhay_Salunke@Dell.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3A5@ausx2kmpc115.aus.amer.dell.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3A5@ausx2kmpc115.aus.amer.dell.com>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 18:53:00 +0200
Message-Id: <1117817580.3656.88.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhay,

> > No no no.  Just because you are using the firmware interface, does not
> > mean you need to add this extra round-trip to the whole system.  Just
> > dump the firmware to the /sys/firmware/whatever... file whenever you
> > want to, that's all that is needed.  No hotplug stuff, no filename
> > stuff, just a simple copy.
> Greg, all the feedback gave the impression that request_firmwae hotplug
> stuff was the way to go. Seems it's not required! Now that means it
> needs to be done the way it was before except that it needs to have a
> bin attribute for data and a normal attribute for size.
> This would be even better as it makes it easy to read back the data.

last time this was discussed somewhere on Linux SCSI with HBA or RAID
adapter card, all pointed to request_firmware(). If Greg disagrees then
I am sorry that I told you to use this interface.

Regards

Marcel


