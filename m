Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWDUH1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWDUH1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDUH1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:27:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:3158 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751267AbWDUH1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:27:43 -0400
X-IronPort-AV: i="4.04,143,1144047600"; 
   d="scan'208"; a="25946352:sNHT19714345"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [RFC] [PATCH] Make ACPI button driver an input device
Date: Fri, 21 Apr 2006 15:27:25 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD13787F2@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] [PATCH] Make ACPI button driver an input device
Thread-Index: AcZksPoV/sXV/XVASKGHwaB98S0DLwAYCDwA
From: "Yu, Luming" <luming.yu@intel.com>
To: <dtor_core@ameritech.net>,
       "Alexey Starikovskiy" <alexey_y_starikovskiy@linux.intel.com>
Cc: "Xavier Bestel" <xavier.bestel@free.fr>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>, <linux-acpi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2006 07:27:27.0063 (UTC) FILETIME=[0A727670:01C66515]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > There are keyboards with power/sleep buttons. It makes 
>sense they have
>> > the same behavior than ACPI buttons.
>> Agree, make them behave like ACPI buttons -- remove them 
>from input stream, as they do not belong there...
>
>What if there is no ACPI? What if I want to remap the button to do
>something else? Input layer is the proper place for them.

If you define input layer as a universe place to all manual input 
activity, then I agree to port some type of ACPI event into
input layer.  But it shouldn't be a fake keyboard scancode,
My suggestion is to have a separate input event type,e.g. EV_ACPI
for acpi event layer.

>
>--
>Dmitry

Thanks,
Luming
