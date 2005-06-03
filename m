Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFCNa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFCNa7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVFCNa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:30:59 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:5387 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261261AbVFCNay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:30:54 -0400
X-IronPort-AV: i="3.93,166,1115010000"; 
   d="scan'208"; a="250283668:sNHT23226000"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Date: Fri, 3 Jun 2005 08:30:44 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3A5@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Thread-Index: AcVn+lZ9PugKQqamQpa6T97bUtgPsAARElYg
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <marcel@holtmann.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 03 Jun 2005 13:30:38.0013 (UTC) FILETIME=[6DDA0ED0:01C56840]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> No no no.  Just because you are using the firmware interface, does not
> mean you need to add this extra round-trip to the whole system.  Just
> dump the firmware to the /sys/firmware/whatever... file whenever you
> want to, that's all that is needed.  No hotplug stuff, no filename
> stuff, just a simple copy.
Greg, all the feedback gave the impression that request_firmwae hotplug
stuff was the way to go. Seems it's not required! Now that means it
needs to be done the way it was before except that it needs to have a
bin attribute for data and a normal attribute for size.
This would be even better as it makes it easy to read back the data.

Thanks
Abhay
