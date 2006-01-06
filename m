Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWAFCGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWAFCGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWAFCGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:06:00 -0500
Received: from fmr24.intel.com ([143.183.121.16]:159 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751901AbWAFCF7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:05:59 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Re. 2.6.15-mm1
Date: Thu, 5 Jan 2006 18:05:03 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB7506494305977CC4@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re. 2.6.15-mm1
Thread-Index: AcYSV2UpfQWfykebQDKTI2NUy/r9WAADUsbg
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Alexander Gran" <alex@zodiac.dnsalias.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>, <ambx1@neo.rr.com>,
       <reiserfs-dev@namesys.com>, <airlied@linux.ie>, <vs@namesys.com>,
       "Dave Jones" <davej@codemonkey.org.uk>
X-OriginalArrivalTime: 06 Jan 2006 02:05:04.0105 (UTC) FILETIME=[9BC58D90:01C61265]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton Thursday, January 05, 2006 4:22 PM

>> 8b 1d 10 00 00 0
>> 0 0f b6 c0 8d 48 04 8d 6c 24
>>  <3>[drm:drm_release] *ERROR* Device busy: 1 0
>> EDAC PCI- Detected Parity Error on 0000:00:1e.0
>
>OK.  I've been assuming that this is a DRM bug but I note that the AGP
tree
>has been dinking with agp_collect_device_status(), so perhaps I had the
>wrong David.
>
>> Additionally every second or so I got these console (and kernel of
>cource)
>> message:
>> EDAC PCI- Detected Parity Error on 0000:00:1e.0
>
>Alan, Rohit: do we expect that the EDAC fixes which you're cooking up
will
>address this?  I think not?
>

Nops.  That one patch does not address this issue.

-rohit
