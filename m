Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKGSOm>; Tue, 7 Nov 2000 13:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbQKGSOc>; Tue, 7 Nov 2000 13:14:32 -0500
Received: from 64.124.41.10.napster.com ([64.124.41.10]:26374 "EHLO
	foobar.napster.com") by vger.kernel.org with ESMTP
	id <S129111AbQKGSOU>; Tue, 7 Nov 2000 13:14:20 -0500
Message-ID: <3A08465A.1AF23D68@napster.com>
Date: Tue, 07 Nov 2000 10:13:46 -0800
From: Jordan Mendelson <jordy@napster.com>
Organization: Napster, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <3A07662F.39D711AE@napster.com> <200011070428.UAA01710@pizda.ninka.net> <3A079127.47B2B14C@napster.com> <200011070533.VAA02179@pizda.ninka.net> <3A079D83.2B46A8FD@napster.com> <200011070603.WAA02292@pizda.ninka.net> <3A07A4B0.A7E9D62@napster.com> <200011070656.WAA02435@pizda.ninka.net> <3A07AC45.DCC961FF@napster.com> <20001107104251.B5081@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Mon, Nov 06, 2000 at 11:16:21PM -0800, Jordan Mendelson wrote:
> > > It is clear though, that something is messing with or corrupting the
> > > packets.  One thing you might try is turning off TCP header
> > > compression for the PPP link, does this make a difference?
> >
> > Actually, there has been several reports that turning header compression
> > does help.
> 
> What does help ? Turning it on or turning it off ?

We had a good number of reports that turning PPP header compression off
helped. The windows 98 connection I was testing with it did have header
compression turned on. Unfortunatly, I can't just ask the entire windows
world to turn off header compression in order to use our software. :)

I believe we've reverted all of our machines to 2.2, so testing this any
further is going to be a problem.


Jordan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
