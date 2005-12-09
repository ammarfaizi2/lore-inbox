Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVLIEcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVLIEcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 23:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVLIEcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 23:32:25 -0500
Received: from fmr16.intel.com ([192.55.52.70]:36047 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751277AbVLIEcY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 23:32:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: ACPI owner_id limit too low
Date: Thu, 8 Dec 2005 23:32:13 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30055EA5DF@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI owner_id limit too low
Thread-Index: AcX8JEdkD3GBZiIASBK4qsgKxfzc5AAU7Mug
From: "Brown, Len" <len.brown@intel.com>
To: "Alex Williamson" <alex.williamson@hp.com>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 09 Dec 2005 04:32:16.0225 (UTC) FILETIME=[888F1D10:01C5FC79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Yes, ACPICA 20051202 upped the limit to 255 from 32,
but as it is mixed in with some other large changes,
I'm thinking I'll that release soak until the opening
of 2.6.17.

So if you need a higher limit in 2.6.15 we can
push this simpler patch, of if Linus shuts down
2.6.15 when we returns we can send it to stable to
get into 2.6.15.*

thanks,
-Len
