Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTBXTWB>; Mon, 24 Feb 2003 14:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTBXTWB>; Mon, 24 Feb 2003 14:22:01 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:27540 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S261451AbTBXTWA> convert rfc822-to-8bit;
	Mon, 24 Feb 2003 14:22:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4.20 amd speculative caching
Date: Mon, 24 Feb 2003 13:32:13 -0600
Message-ID: <A5D66E6B6F478B48A3CEF22AA4B9FCA3012E58@umr-mail1.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.20 amd speculative caching
Thread-Index: AcLZASY55HiREqNBRg2YYMZ2S7EjBwADax1AAMsKUoA=
From: "Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>
To: "Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's seems that I was experiencing hardware problems. I swapped
everything on to a new board and it worked fine. The weird thing is that
I swapped everything back and the old board now works fine now as well!
It is hard for me to imagine that reseating everything fixed it, because
I did that multiple times before.
		Thanks for all the help!
                     Craig (sowadski@umr.edu)
  

-----Original Message-----
From: Sowadski, Craig Harold (UMR-Student) 
Sent: Thursday, February 20, 2003 12:49 PM
To: Sowadski, Craig Harold (UMR-Student)
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.20 amd speculative caching

AMD's website has some documentation that says the morgan core durons
are affected. 

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/
26698.pdf

I am using only stock linus kernel driver for the agpgart and radeon.
Also, the system has now started locking up with 2.4.19 so I installed
WINDOWS (sorry) to see if it showed similar problems and it did (even
with the win2000 agp update). I have swaped the PS, RAM, and video card
with the same problems. I plan on swapping the MB with an identical
replacement to see if that helps. I will let you know if I conclude it
to be a hardware or software problem when I get some more parts to swap.
Sorry for bothering with what might be a hardware problem.

		Thanks for all the help!!
		Craig Sowadski (sowadski@umr.edu)
    

-----Original Message-----
From: Randal, Phil [mailto:prandal@herefordshire.gov.uk] 
Sent: Thursday, February 20, 2003 10:50 AM
To: Sowadski, Craig Harold (UMR-Student)
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.20 amd speculative caching

According to Richard Brunner of AMD's email to the list dated June 11,
2002,
the cache attribute bug only affected Athlon XPs and MPs, so that can't
be
the problem here, can it?

Cheers,

Phil

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK 

> -----Original Message-----
> From: Dave Jones [mailto:davej@codemonkey.org.uk]
> Sent: 20 February 2003 16:53
> To: Sowadski, Craig Harold (UMR-Student)
> Cc: Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: 2.4.20 amd speculative caching
> 
> 
> On Wed, Feb 19, 2003 at 01:13:28PM -0600, Sowadski, Craig 
> Harold (UMR-Student) wrote:
> 
>  > If it helps, here is my hardware config:
>  > 
>  > 	AMD Duron 1300MHZ
>  > 	MSI K7T Turbo-2
>  > 	ATI Radeon 7500 w/64mb
>  > 	Redhat 8.0
> 
> Are you using the ATi firegl drivers ? If so, thats likely the
> problem. (They ship an agpgart based upon 2.4.16 which lacks
> the fixes needed).
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
