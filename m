Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAKMlN>; Thu, 11 Jan 2001 07:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130797AbRAKMlD>; Thu, 11 Jan 2001 07:41:03 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:32731 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129846AbRAKMkw>; Thu, 11 Jan 2001 07:40:52 -0500
Message-ID: <3A5DAB5E.6F4B05B7@uow.edu.au>
Date: Thu, 11 Jan 2001 23:47:26 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: Updated zerocopy patch up on kernel.org
In-Reply-To: <200101100055.QAA07674@pizda.ninka.net> <Pine.LNX.4.30.0101111137360.981-100000@e2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Tue, 9 Jan 2001, David S. Miller wrote:
> 
> > Nothing interesting or new, just merges up with the latest 2.4.1-pre1
> > patch from Linus.
> >
> > ftp.kernel.org:/pub/linux/kernel/people/davem/zerocopy-2.4.1p1-1.diff.gz
> >
> > I haven't had any reports from anyone, which must mean that it is
> > working perfectly fine and adds no new bugs, testers are thus in
> > nirvana and thus have nothing to report.  :-)
> 
> (works like a charm here.)

For the record...

I've been running it since release on 2.4.0-UP/x86.  The
NIC is a 3c905B so we're doing scater/gather and hw
checksumming.  It does a lot of NFS client work
against a Netapp server.  rsize=wsize=8192.

I'm not using sendfile().

IOW: me too.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
