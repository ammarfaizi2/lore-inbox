Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBIHSJ>; Fri, 9 Feb 2001 02:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129626AbRBIHR7>; Fri, 9 Feb 2001 02:17:59 -0500
Received: from beops-jg2.office.be.uu.net ([194.7.16.143]:48257 "HELO
	dhcp194-7-17-95.office.uunet.be") by vger.kernel.org with SMTP
	id <S129030AbRBIHRu>; Fri, 9 Feb 2001 02:17:50 -0500
From: "Jan Gyselinck" <jan.gyselinck@be.uu.net>
Date: Fri, 9 Feb 2001 08:04:54 +0100
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
Message-ID: <20010209080454.A17656@beops-jg2.be.uu.net>
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net> <95v8am$k6o$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <95v8am$k6o$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Feb 08, 2001 at 02:58:30PM -0800
Organization: UUNET
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 02:58:30PM -0800, H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net>
> By author:    Gerhard Mack <gmack@innerfire.net>
> In newsgroup: linux.dev.kernel
> >
> > Thanklfully bind 9 barfs if you even try this sort of thing.
> > 
> 
> Personally I find it puzzling what's wrong with MX -> CNAME at all; it
> seems like a useful setup without the pitfalls that either NS -> CNAME
> or CNAME -> CNAME can cause (NS -> CNAME can trivially result in
> irreducible situations; CNAME -> CNAME would require a link maximum
> count which could result in obscure breakage.)
> 
> 	-hpa

There's not really something wrong with MX's pointing to CNAME's.  It's just that some mailservers could (can?) not handle this.  So if you want to be able to receive mail from all kinds of mailservers, don't use CNAME's for MX's.

Regards


Jan Gyselinck
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
