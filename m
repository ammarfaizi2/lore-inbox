Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316435AbSEOQi3>; Wed, 15 May 2002 12:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316436AbSEOQi3>; Wed, 15 May 2002 12:38:29 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:42382
	"EHLO awak") by vger.kernel.org with ESMTP id <S316435AbSEOQi1> convert rfc822-to-8bit;
	Wed, 15 May 2002 12:38:27 -0400
Subject: Re: No Network after Compiling,2.4.19-pre8 under Debian Woody	(Long
	Message)
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux-kernel@vger.kernel.org
In-Reply-To: <000f01c1fc45$ff2d0cd0$2000a8c0@metalbox>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 May 2002 18:38:15 +0200
Message-Id: <1021480696.17761.11.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it works at 10Mbit. But the driver doesn't do speed negociation, it
doesn't even see the MII registers. However I think RTL8139 cards have
MII registers. I quickly looked at the source but didn't see anything
special.


Le mer 15/05/2002 à 21:23, Andre LeBlanc a écrit :
> Does your netowrk work at all though?
> 
> ----- Original Message -----
> From: "Xavier Bestel" <xavier.bestel@free.fr>
> To: "Andre LeBlanc" <ap.leblanc@shaw.ca>
> Cc: "bert hubert" <ahu@ds9a.nl>; "Linux Kernel Mailing List"
> <linux-kernel@vger.kernel.org>
> Sent: Wednesday, May 15, 2002 8:57 AM
> Subject: Re: No Network after Compiling,2.4.19-pre8 under Debian Woody (Long
> Message)
> 
> 
> Le mer 15/05/2002 à 01:50, Andre LeBlanc a écrit :
> >
> > I also noticed that when booting, the 2.2.20 kernel identifies media type
> > 100MBit Full duplex, and under 2.4.19-pre8 it detects 10MBit half duplex.,
> > if that makes a difference
> 
> Same thing here. I'm really interested why.
> 
> 
> Xav
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


