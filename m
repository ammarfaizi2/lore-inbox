Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWFGWjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWFGWjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWFGWjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:39:03 -0400
Received: from mga03.intel.com ([143.182.124.21]:52999 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932451AbWFGWjC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:39:02 -0400
X-IronPort-AV: i="4.05,218,1146466800"; 
   d="scan'208"; a="47639309:sNHT659883420"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ANNOUNCE: Linux UWB and Wireless USB project
Date: Wed, 7 Jun 2006 15:41:05 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A06461EDF@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ANNOUNCE: Linux UWB and Wireless USB project
Thread-Index: AcaI7M1rANl92X6vS7+tvwbxq0A5LwBlXAXg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Pavel Machek" <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 07 Jun 2006 22:38:38.0247 (UTC) FILETIME=[1E6D5B70:01C68A83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>
>Ar Llu, 2006-06-05 am 13:31 -0700, ysgrifennodd Perez-Gonzalez, Inaky:
>> For what I know (and I could be wrong) max is around -40dBm/MHz
>> in the US. I am no expert in the nitty-gritty radio details, but
>> I've been told that is 3000 times less emissions than a common
>> cellphone, around .1 uW? [this is where my knowledge about radio
>> *really* fades].
>
>Life is never that simple. The total emissions of UWB are pretty low
but
>their spread across the wide frequency range makes them incredibly low
>on any frequency - so very unlikely to interfere.
>
>The total emissions across the set of frequencies as a sum (with
>emphasis on some frequency ranges such as 2.4-2.5GHz) apparently
matters
>much more than the emissions at one frequency for things like human
>exposure.

Right -- I asked our local radio wizard (so I could get more details)
and taking into account that each band is 1584 MHz wide at a max of
-41.3 dBm/Mhz, it yields something like 117 uW per band. He also added 
that once you consider all the fine points it goes down to 100uW per
band 
(-10dBm).

To answer Pavel's question on hardware power consumption, I don't really

know -- too early to tell; however, whoever architected the technology
was keeping in mind a target market similar to bluetooth's, really small
devices and embedded, home entertainment, cell phones, printers, cameras
and the like; it'll be pretty low.

-- Inaky
