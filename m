Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVLFM0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVLFM0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVLFM0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:26:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:19678 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751446AbVLFM0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:26:53 -0500
From: "David Engraf" <engraf.david@netcom-sicherheitstechnik.de>
To: "'Bernd Petrovitsch'" <bernd@firmix.at>
Cc: <linux-kernel@vger.kernel.org>, "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
Date: Tue, 6 Dec 2005 13:26:43 +0100
Message-ID: <000201c5fa60$52bb53e0$0a016696@EW10>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1133871202.3664.34.camel@tara.firmix.at>
Thread-Index: AcX6X14/RZPwoVSoR+yA3aNY+Rmx3wAAJkEQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:79a9c929f10b28b00e544b1aedb42267
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2005-12-06 at 12:23 +0100, David Engraf wrote:
> > > On Tue, 2005-12-06 at 11:36 +0100, David Engraf wrote:
> [.../9
> > > 3) wouldn't it be better to expose a wallclock time thing which
> > >    has a constant unit of time between all kernels?
> >
> > What is it?
> >
> >
> > > (and.. wait.. isn't that called gettimeofday() )
> > Not really gettimeofday is based on the date and time, but what if the
> user
> > changes the date, the counter would also change.
> 
> man 2 times
> And use the returned value.
> 
> 	Bernd
> --
> Firmix Software GmbH                   http://www.firmix.at/
> mobil: +43 664 4416156                 fax: +43 1 7890849-55
>           Embedded Linux Development and Services

times has only 10ms resolution, we need at least 1ms.

David


____________
Virus checked by G DATA AntiVirusKit
Version: AVK 16.2039 from 06.12.2005
Virus news: www.antiviruslab.com

