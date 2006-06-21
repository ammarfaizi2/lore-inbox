Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWFUEnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWFUEnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWFUEnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:43:07 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:10531 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S932463AbWFUEnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:43:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilitiesKJ
Date: Tue, 20 Jun 2006 21:42:56 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF12@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilitiesKJ
Thread-Index: AcaUu7kkKr7IzCT/TZae6Q3DUTXGGgAMJujw
From: "Allen Martin" <AMartin@nvidia.com>
To: "Andi Kleen" <ak@suse.de>, "Greg KH" <gregkh@suse.de>
Cc: "Dave Olson" <olson@unixfolk.com>, <discuss@x86-64.org>,
       "Brice Goglin" <brice@myri.com>, <linux-kernel@vger.kernel.org>,
       "Greg Lindahl" <greg.lindahl@qlogic.com>
X-OriginalArrivalTime: 21 Jun 2006 04:42:57.0586 (UTC) FILETIME=[2AFA8920:01C694ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> NForce4 PCI Express is an unknown - we'll see how that works.
> 

MSI is not officially supported on nForce4 and hasn't been fully tested.

However it should work ok for PCI-E.  I would definitely not recommend
enabling 
MSI for the internal MAC though.

-Allen
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
