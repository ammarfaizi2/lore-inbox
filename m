Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTBTRjF>; Thu, 20 Feb 2003 12:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTBTRjF>; Thu, 20 Feb 2003 12:39:05 -0500
Received: from fmr01.intel.com ([192.55.52.18]:51949 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266243AbTBTRjD> convert rfc822-to-8bit;
	Thu, 20 Feb 2003 12:39:03 -0500
content-class: urn:content-classes:message
Subject: RE: 8x AGP under linux?
Date: Thu, 20 Feb 2003 09:48:58 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00143B5C2@fmsmsx406.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 8x AGP under linux?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLZBgAKKBocg0T4Edeo9ABQi2jWzAAAdiIA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Dave Jones" <davej@codemonkey.org.uk>,
       "Casey Lancour" <cjlancour@link.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Feb 2003 17:48:59.0307 (UTC) FILETIME=[58D44FB0:01C2D908]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casey, I can send you the 2.4 patch for the E7205/E7505 chipsets that I posted a while back that also incorporates AGP 3.0 support if you are interested.  However as Dave mentioned, I did have quite a bit of trouble with the Nvidia 8x binary only driver, so ymmv....

matt

> -----Original Message-----
> From: Dave Jones [mailto:davej@codemonkey.org.uk]
> Sent: Thursday, February 20, 2003 9:36 AM
> To: Casey Lancour
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 8x AGP under linux?
> 
> 
> On Thu, Feb 20, 2003 at 11:00:56AM -0600, Casey Lancour wrote:
>  > Does anyone know the status to 8x agp support under linux?
>  > I am using the Granite bay 7205 chipset and I cant get my 
> geforce4 card
>  > to use agpgart or nvidia's agp support, it seems to be 
> defaulting to pci
>  > mode (not even using 4x agp).
>  > I do a:
> 
> For 2.4, there is a patch for that chipset (that didnt get merged
> to mainline). 2.5 has it supported out-of-the-box, but likely
> breaks with your binary nvidia driver.
> 
> 		Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
