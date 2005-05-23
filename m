Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVEWOwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVEWOwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEWOwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:52:11 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:6225 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261878AbVEWOwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:52:08 -0400
X-IronPort-AV: i="3.93,129,1115010000"; 
   d="scan'208"; a="264133887:sNHT23382782"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Date: Mon, 23 May 2005 09:52:05 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED388@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Thread-Index: AcVcIrYy481zkvJsQjGsl5DHS0ZzuQDg4sUw
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 23 May 2005 14:52:06.0269 (UTC) FILETIME=[FCEF7AD0:01C55FA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
> 
> Also, what's wrong with using the existing firmware interface in the
> kernel?
request_firmware requires the $FIRMWARE env to be populated with the
firmware image name or the firmware image name needs to be hardcoded
within  the call to request_firmware. Since the user is free to change
the BIOS update image at will, it may not be possible if we use
$FIRMWARE also I am not sure if this env variable might be conflicting
to some other driver.

Thanks
Abhay
