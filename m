Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbSLRSVI>; Wed, 18 Dec 2002 13:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbSLRSVI>; Wed, 18 Dec 2002 13:21:08 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:40894 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S267329AbSLRSVH> convert rfc822-to-8bit;
	Wed, 18 Dec 2002 13:21:07 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00 series cards
Date: Wed, 18 Dec 2002 12:29:05 -0600
Message-ID: <B578DAA4FD40684793C953B491D487913F0F9B@umr-mail7.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00 series cards
Thread-Index: AcKmwwr9WmBSaJKJSYefEYDZCDx65wAABDag
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "Dave Jones" <davej@codemonkey.org.uk>
Cc: <linux-kernel@vger.kernel.org>, "Uetrecht, Daniel J." <uetrecht@umr.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, no... (I don't actually know for certain that 2.5.x is
broke, only that 2.4.x is. The 2.5.x comment is based on the driver
version only.)

They said that that newest version of the driver that should be used
with 6xxx cards is .016. I haven't tried stepping up through the
revisions. 

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216


> -----Original Message-----
> From: Dave Jones [mailto:davej@codemonkey.org.uk] 
> Sent: Wednesday, December 18, 2002 12:26 PM
> To: Neulinger, Nathan
> Cc: linux-kernel@vger.kernel.org; Uetrecht, Daniel J.
> Subject: Re: 3ware driver in 2.4.x and 2.5.x not compatible 
> with 6x00 series cards
> 
> 
> On Wed, Dec 18, 2002 at 12:10:54PM -0600, Nathan Neulinger wrote:
>  > According to 3Ware, the driver in the 2.4.x and (I assume) 
> 2.5.x is no
>  > longer compatible with the 6xxx series cards. 
>  > I don't know what we'll do with this situation when we 
> move to 2.6, cause
>  > right now, it looks like we are completely screwed. The old driver 
>  > obviously will not compile on 2.6 since the API's have changed. 
> 
> Any idea at which point the 2.5 driver stopped working ?
> It may not be that much work to bring that version up to date as
> a 3ware-old.c driver in a worse-case scenario.
> 
> This would be huge code duplication however, and would be much
> better fixed by having the driver detect which card its running
> on, and 'do the right thing' wrt which firmware it needs.
> 
> 		Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> 
