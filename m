Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <161149-221>; Thu, 25 Mar 1999 08:41:34 -0500
Received: by vger.rutgers.edu id <160905-221>; Thu, 25 Mar 1999 08:41:25 -0500
Received: from Cantor.suse.de ([194.112.123.193]:7354 "HELO Cantor.suse.de" ident: "TIMEDOUT") by vger.rutgers.edu with SMTP id <160927-220>; Thu, 25 Mar 1999 08:41:12 -0500
Date: Thu, 25 Mar 1999 14:40:48 +0100 (MET)
From: Michael Hasenstein <mha@suse.de>
To: Greg Maxwell <gmaxwell@Martin.FL.US>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: NAT and 2.2?
In-Reply-To: <Pine.GSO.3.96.990325081514.5266A-100000@da1server>
Message-ID: <Pine.LNX.4.10.9903251434350.25052-100000@Benjy.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 25 Mar 1999, Greg Maxwell wrote:

> Can the new IP ROUTE stuff in 2.2 do ONE-ONE NAT insted of the standard

check http://www.csn.tu-chemnitz.de/HyperNews/get/linux-ip-nat.html
long term solution will probably be 2.3, see ipchain homepage, new
netfilter code, I'm looking into contributing there right now, but since
you need something fast... the stuff on the page above is in production
use by some insane people; both 2.2 and 2.0 versions work (if you get the
right one, you should now how to patch a kernel and being able to read
the code certainly helps)
there's NAT code in the current 2.2 series, haven't tried that, don't know
if it works and how well it works
disadvantage of both: no protocol specific NAT available (i.e. ftp won't
work, if you only NAT src OR dest, one of PASV/reg. ftp will work, though,
but not if you NAT both
don't forget to read the 50 page document on that site ;-)


--
Michael Hasenstein
http://www.csn.tu-chemnitz.de/~mha/
Private Pilot (ASEL) since 1998


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
