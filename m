Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVCaQj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVCaQj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVCaQj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:39:56 -0500
Received: from fmr19.intel.com ([134.134.136.18]:26031 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261553AbVCaQjy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:39:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.11.6-bk2] e100: Use EEPROM config for Auto MDI/MDI-X
Date: Thu, 31 Mar 2005 08:39:28 -0800
Message-ID: <468F3FDA28AA87429AD807992E22D07E04BFF982@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.11.6-bk2] e100: Use EEPROM config for Auto MDI/MDI-X
Thread-Index: AcU1LhPHi7BpQuzXQVShaoeiYQmT8AA4gDKg
From: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
To: "Eran Mann" <emann@mrv.com>, "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Netdev" <netdev@oss.sgi.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux NICS" <linuxnics@mailbox.cps.intel.com>
X-OriginalArrivalTime: 31 Mar 2005 16:39:29.0795 (UTC) FILETIME=[35AEC530:01C53610]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eran:

Good catch. We will include this patch in the next release of our
driver.

Thanks,
Ganesh.

>-----Original Message-----
>From: Eran Mann [mailto:emann@mrv.com]
>Sent: Wednesday, March 30, 2005 5:42 AM
>To: Jeff Garzik
>Cc: Netdev; Linux Kernel; Linux NICS; Venkatesan, Ganesh
>Subject: [PATCH 2.6.11.6-bk2] e100: Use EEPROM config for Auto
MDI/MDI-X
>
>Current e100.c doesn't follow the EEPROM configuration regarding Auto
>MDI/MDI-X switching, instead it is enabled unconditionally for the
>relevant chips.
>This is especially bad since according to Intel's errata this feature
is
>no-longer supported.
>
>Signed-off-by: Eran Mann <emann@mrv.com>
