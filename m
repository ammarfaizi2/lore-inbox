Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129336AbRBIAn6>; Thu, 8 Feb 2001 19:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRBIAns>; Thu, 8 Feb 2001 19:43:48 -0500
Received: from quattro.sventech.com ([205.252.248.110]:23312 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129336AbRBIAnf>; Thu, 8 Feb 2001 19:43:35 -0500
Date: Thu, 8 Feb 2001 19:43:33 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Michael H. Warfield" <mhw@wittsend.com>, linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
Message-ID: <20010208194332.Y23514@sventech.com>
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net> <95v8am$k6o$1@cesium.transmeta.com> <20010208183232.A1642@alcove.wittsend.com> <3A833005.5C8E0D81@transmeta.com> <20010208185449.B1642@alcove.wittsend.com> <3A83335A.A5764CD7@transmeta.com> <20010208190823.B1640@alcove.wittsend.com> <3A8335BB.F3166F1@transmeta.com> <20010208193120.C1640@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010208193120.C1640@alcove.wittsend.com>; from Michael H. Warfield on Thu, Feb 08, 2001 at 07:31:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001, Michael H. Warfield <mhw@wittsend.com> wrote:
> 	But, wait a minute.  CNAME -> CNAME is a "must not".  MX -> CNAME
> is a "should not".  The "should not" leaves it to be implimentation
> dependent and not an outright ban.  Sooo...

Actually, I had this conversation recently. I checked a variety of
places and I couldn't find an RFC that said CNAME -> CNAME is a "must
not". In fact I found this snippet in rfc1912 which seems to imply that
it is legal:

   Also, having chained records such as CNAMEs pointing to CNAMEs may
   make administration issues easier, but is known to tickle bugs in
   some resolvers that fail to check loops correctly.  As a result some
   hosts may not be able to resolve such names.

*shrug*

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
