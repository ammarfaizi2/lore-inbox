Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313843AbSDJVSw>; Wed, 10 Apr 2002 17:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313848AbSDJVSv>; Wed, 10 Apr 2002 17:18:51 -0400
Received: from mail.myrio.com ([63.109.146.2]:1269 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S313843AbSDJVSv> convert rfc822-to-8bit;
	Wed, 10 Apr 2002 17:18:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
Date: Wed, 10 Apr 2002 14:18:25 -0700
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3D3@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
Thread-Index: AcHgygcMZ+7jVFP4QkqRGIA+OK/aKQACNYmQ
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Florian Weimer" <Weimer@CERT.Uni-Stuttgart.DE>,
        "James Simmons" <jsimmons@transvirtual.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Apr 2002 21:17:40.0335 (UTC) FILETIME=[25688FF0:01C1E0D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:
[...]
> >> > rather similar to what I use for reiserfs, which is free 
> for use with
> >> > free operating systems only,
> >> 
> >> Really?  I thought ReiserFS was released under the GPL.  Is this no
> >> longer the case?
> >
> > Because something is GPL doesn't mean it is free dollar 
> wise. GPL is free
> > as in free speech not free beer.
> 
> That's not my point.  Of course you can charge for GPLed software, or,
> as the copyright holder, offer different licensing options for a fee.
> 
> However, if you release software under the GPL, you do not prevent
> people from using it on proprietary operating systems.

well, technically that's true.  However they would not be able to link 
it into the proprietary operating system and then distribute it without 
violating the GPL.  

So the only ways to put reiserFS on (say) Win2K would be to:

- Pay for and get a separate, non-GPL license from Hans Reiser and 
  his team, which is perfectly legitimate for them to do as the 
  copyright holders,

- or, implement it in _user-space_ as an entirely GPL'ed application.
  Obviously this second option would be difficult, I don't know 
  if Win2K supports user-space filesystems at all.  At the least, it 
  would have negative performance and reliability implications...

- or, do whatever you want but never distribute it at all.

Not to speak for Mr. Reiser, but I believe that's what he meant when
he said it's free for use with free operating systems only.

Finally, that second option could be even more difficult... I hear 
MS has recently changed the terms of their C run-time-library license
to forbid use by GPLed code. If so, you'd have to use a different C 
library for Windows...

Torrey Hoffman
