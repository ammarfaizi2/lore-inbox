Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZFH1>; Fri, 26 Jan 2001 00:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRAZFHS>; Fri, 26 Jan 2001 00:07:18 -0500
Received: from foozle.turbogeek.org ([216.233.172.106]:15624 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S129143AbRAZFHA>; Fri, 26 Jan 2001 00:07:00 -0500
Date: Thu, 25 Jan 2001 23:06:53 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010125230653.A1850@foozle.turbogeek.org>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <94qcvm$9qp$1@cesium.transmeta.com> <14960.54069.369317.517425@pizda.ninka.net> <3A70D524.11362EFB@transmeta.com> <14960.54852.630103.360704@pizda.ninka.net> <3A70D7B2.F8C5F67C@transmeta.com> <14960.56461.296642.488513@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14960.56461.296642.488513@pizda.ninka.net>; from davem@redhat.com on Thu, Jan 25, 2001 at 06:10:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001 18:10:21 +0000, David S. Miller wrote:
> It says "reserved for future use, must be zero".

While I've not checked the context yet, this seems to be terrible
wording. The context doesn't direct this towards hosts constructing
packets? What is the 'It' you refer to, the TCP RFC? Do any of the
following override this awful wording job?

RFC1122 / STD0003    Requirements for Internet hosts (comm. layers)
RFC1123 / STD0003    Requirements for Internet hosts (apps)
RFC1009 / STD0004    Requirements for Internet gateways 
RFC1812              Requirements for IP Version 4 Routers 
RFC2979              Behavior of and Requirements for Internet Firewalls 

The last one seems it would have the most potential to clear up this
mess, unfortunatly it's only an informational RFC, and at a quick
glance, doesn't look like it addresses this issue. Regardless, the
intent of the author was clear... it'd just be nice to be able to
quote chapter and verse.

Besides, I'm MUCH more worried about all of .uk being behind an ECN
eating router then not being about to talk to some Microsoft webmail
service.

I fear this problem is doomed to repeat itself as well, as more of
IP's features become unreserved (Class E IP Address, anyone?)

/jmd

-- 
Jeremy M. Dolan <jmd@turbogeek.org>
OpenPGP key = http://turbogeek.org/openpgp-key
OpenPGP fingerprint = 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
