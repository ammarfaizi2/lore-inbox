Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266151AbRGQLta>; Tue, 17 Jul 2001 07:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266150AbRGQLtW>; Tue, 17 Jul 2001 07:49:22 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:56846 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S266138AbRGQLtF>;
	Tue, 17 Jul 2001 07:49:05 -0400
Date: Tue, 17 Jul 2001 13:48:07 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<christian@borntraeger.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B5425F7.45A7B8D1@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en
In-Reply-To: <3B5413C9.2CE16AC9@uni-mb.si> <01071713144700.02683@Einstein.P-netz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:
> 
> > /proc/cpuinfo gives :
> > cache size: 64 KB
> >
> > This is wrong :
> >  - the Duron has 192 kilobytes of cache ( 64 L1 I, 64 L1 D , 64 L2 unified
> > ) - what is KB ?
> 
> As far as I know older Durons have a bug. They report a wrong size for the
> cache.

The kernel messages at boot have no trouble finding out the correct
cache info.

> >    - "kilo" is abbreviated to 'k' , not 'K'
> 
> Hmm, I think kilo is 1000 and K is 1024.


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
