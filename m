Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266297AbUBDE0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266302AbUBDE0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:26:38 -0500
Received: from fmr06.intel.com ([134.134.136.7]:1234 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266297AbUBDE0d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:26:33 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Tue, 3 Feb 2004 08:45:32 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3664@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPp9oYxPA64kD7QSZ2b7GUy1dhocwAfP5Ag
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Masanori ITOH" <marc@labs.fujitsu.com>, <woody@jf.intel.com>
Cc: <hozer@hozed.org>, <infiniband-general@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Feb 2004 16:45:32.0626 (UTC) FILETIME=[239FE320:01C3EA75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masonori, 

I think that Sean has already pushed the code changes for 2.6 for 
complib, IBAL, and SDP.  As I stated before, we have yet to test it on
2.6,
but it should now compile. Let us know if you have any issues.


-----Original Message-----
From: Masanori ITOH [mailto:marc@labs.fujitsu.com] 
Sent: Monday, February 02, 2004 5:39 PM
To: woody@jf.intel.com
Cc: hozer@hozed.org; infiniband-general@lists.sourceforge.net;
linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
the linux kernel


Hello Folks,

Message-ID:
<F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
> 
> We were waiting until we had some version of the InfiniBand code 
> ported to 2.6 before asking for it to be included in the 2.6 kernel 
> tree. Jerrie made the changes
> to the IB access layer to allow it to compile on 2.6, but it cannot
yet
> be tested 
> till we get a 2.6 driver from Mellanox. 

Now, I'm testing a VPD for Fujitsu InfiniBand HCA card.
The VPD requires no special SDK such as VAPI of Mellanox.

In order to do that, I made some changes locally on IBAL and COMPLIB
layers based on the change set 1.207. I still have some problems, but
opensm and ipoib are working on linux-2.6.1 environment.

Robert, if you could make Jarrie's modification public at bkbits.net, I
can test the modification for 2.6 kernel using Fujitsu HCA.

Meanwhile, Mellanox is not the only supplier of InfiniBand HCA. Fujitsu,
Japan, also has InfiniBand HCA card with an original LSI 
different from Tavor chip.

Thanks in advance,
Masanori

> I'd also like to hear from the linux-kernel folks on what we would 
> need to do to get a basic InfiniBand access layer included in the 2.6 
> base.
> 
> We'd also like to hear from Mellanox if they have any plans to provide

> an open source VPD driver anytime soon.
> 
> woody

---
Masanori ITOH  Grid Computing & Bioinformatics Lab., Fujitsu Labs. LTD.
               e-mail: marc@labs.fujitsu.com
               phone: +81-44-754-2628 (extension: 7112-6227)
               FingerPrint: 55AF C562 E415 FB1A 8A3A  35D1 AB40 8A9D
B8B1 99F8
