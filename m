Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSJ3JKY>; Wed, 30 Oct 2002 04:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSJ3JKY>; Wed, 30 Oct 2002 04:10:24 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:64677 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S264628AbSJ3JKX>; Wed, 30 Oct 2002 04:10:23 -0500
Subject: RE: AIM Bench Mark results for different kernels
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-96824ec1-80b0-43a8-b56b-15e98fe83bfd"
Date: Wed, 30 Oct 2002 14:46:37 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
Message-ID: <7F396B9772328640B7593FA817EEEDAD05FF85@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AIM Bench Mark results for different kernels
Thread-Index: AcJ/4IkcfeihJy7dTzicE/Ee9dj1qQAE+7QQ
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Oct 2002 09:16:37.0856 (UTC) FILETIME=[0CD16600:01C27FF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-96824ec1-80b0-43a8-b56b-15e98fe83bfd
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for your feedback.

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@digeo.com]=20
> Sent: Wednesday, October 30, 2002 12:19 PM
> To: Pavan Kumar Reddy N.S.
> Cc: kernelnewbies@nl.linux.org; linux-kernel@vger.kernel.org
> Subject: Re: AIM Bench Mark results for different kernels
>=20
>=20
> "Pavan Kumar Reddy N.S." wrote:
> >=20
> >=20
> > AIM Independent Resource Benchmark - Suite IX v1.1, January=20
> 22, 1996=20
> > Copyright (c) 1996 - 2001 Caldera International, Inc. All Rights=20
> > Reserved
> >=20
> >
>=20
> Thanks.
>=20
> This would be enormously less painful to read if you could=20
> fix your mailer to not word-wrap your content.

I will take care of this...

>=20
> All the compute-intensive workloads are down ~1% because of=20
> the increase of HZ from 100 to 1000.
>=20
> Things like "sequential disk reads (K)/second" would be more=20
> interesting if they were accompanied by CPU utilisation.  But=20
> then, CPU utilisation comparisons with 2.4 kernels are=20
> suspect because of the HZ change.  Probably it would be more=20
> informative if the 2.5 kernel was altered to run at HZ=3D100,=20
> or run 2.4 at HZ-1000.

I will rerun for all the kernels after changing the HZ as you
Mentioned above. I will try to give the CPU utilization
Information along with the above results.

>=20
> 2.5.43 outperformed 2.5.42 and 2.5.44 by a *lot* in many=20
> tests. That is unexpected.  It might be worth double-checking=20
> that result.
>=20
I will.

------=_NextPartTM-000-96824ec1-80b0-43a8-b56b-15e98fe83bfd
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

------=_NextPartTM-000-96824ec1-80b0-43a8-b56b-15e98fe83bfd--
