Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266314AbSKGDlm>; Wed, 6 Nov 2002 22:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266315AbSKGDlm>; Wed, 6 Nov 2002 22:41:42 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:20910 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S266314AbSKGDlk>; Wed, 6 Nov 2002 22:41:40 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-6d9993d4-2405-4c39-ae3f-40f20eaf1cab"
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Subject: RE: [Lmbench-users] Latest kernel LMBench performance results.(wi th HZ=1000)
Date: Thu, 7 Nov 2002 09:18:10 +0530
Message-ID: <7F396B9772328640B7593FA817EEEDAD08ACBA@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lmbench-users] Latest kernel LMBench performance results.(wi th HZ=1000)
Thread-Index: AcKGCz4qMqe5BAuFQ6+PD9YhCenq3AABNFZw
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Ralf Baechle" <ralf@linux-mips.org>,
       "Nagel Michael" <Michael.Nagel@fci.com>
Cc: <lmbench-users@bitmover.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Nov 2002 03:48:10.0620 (UTC) FILETIME=[7DB1D3C0:01C28610]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-6d9993d4-2405-4c39-ae3f-40f20eaf1cab
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


There is debugging code enabled for the loopback interface
in 2.5.x to test out some new features in the networking stack.
This is another reason for the performance drop.

-pavan

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org]=20
> Sent: Thursday, November 07, 2002 8:33 AM
> To: Nagel, Michael
> Cc: lmbench-users@bitmover.com
> Subject: Re: [Lmbench-users] Latest kernel LMBench=20
> performance results.(wi th HZ=3D1000)
>=20
>=20
> On Wed, Nov 06, 2002 at 10:05:17AM +0100, Nagel, Michael wrote:
>=20
> > Reading the results I saw a noticeable decrease of the TCP=20
> performance=20
> > between the 2.4.x and the 2.5.x kernels. Any explanations=20
> on that? How=20
> > about the impact on performance for server-related applications?
>=20
> That's a typical observation for development kernels and=20
> should not be valued to highly.  In the past month large=20
> parts of the kernel code have be rewritten.  All these=20
> subsystems and their frequently very subtle interaction with=20
> each other still need alot of fine tuning which will happen=20
> as we progress further to a 2.6 release and probably even=20
> beyond 2.6.0.
>=20
>   Ralf
> _______________________________________________
> Lmbench-users mailing list
> Lmbench-users@bitmover.com=20
> http://bitmover.com/mailman/listinfo/lmbench-> users
>=20

------=_NextPartTM-000-6d9993d4-2405-4c39-ae3f-40f20eaf1cab
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-6d9993d4-2405-4c39-ae3f-40f20eaf1cab--
