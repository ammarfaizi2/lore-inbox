Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266138AbRGQLta>; Tue, 17 Jul 2001 07:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266151AbRGQLtV>; Tue, 17 Jul 2001 07:49:21 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:57102 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S266150AbRGQLtF>;
	Tue, 17 Jul 2001 07:49:05 -0400
Date: Tue, 17 Jul 2001 13:47:10 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B5425BE.6CB48F75@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en
In-Reply-To: <3B5413C9.2CE16AC9@uni-mb.si> <01071713343600.02787@Einstein.P-netz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:
> 
> > CPU AMD Duron 700
> >
> > /proc/cpuinfo gives :
> > cache size: 64 KB
> 
> With an Athlon I get 256KB.
> So I guess, that cache size shows only the 2nd level cache size.

Well then it should say "L2 cache size:"
It is a bug in any case.

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
