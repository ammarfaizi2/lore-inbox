Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSK0Iv0>; Wed, 27 Nov 2002 03:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSK0Iv0>; Wed, 27 Nov 2002 03:51:26 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:64527
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S261723AbSK0IvZ>; Wed, 27 Nov 2002 03:51:25 -0500
Subject: Re: [NFS] htree+NFS (NFS client bug?)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <shsptsrd761.fsf@charged.uio.no>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	 <shsptsrd761.fsf@charged.uio.no>
Content-Type: multipart/mixed; boundary="=-d/ocxyxY5hacsrgsFMfn"
Organization: 
Message-Id: <1038387522.31021.188.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Nov 2002 00:58:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d/ocxyxY5hacsrgsFMfn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-11-26 at 19:26, Trond Myklebust wrote:
> >>>>> " " == Jeremy Fitzhardinge <jeremy@goop.org> writes:
> 
>      > It looks to me like some sort of problem managing the NFS
>      > readdir cookies, but it isn't clear to me whether this is the
>      > NFS server/ext3 generating bad cookies, or the NFS client
>      > handling them wrongly.
> 
> In order to determine which of the two needs to be fixed, it would
> help if you could print out the cookies from that listing or better
> still: if you could provide us with the raw tcpdump output. Please
> remember to use an 8k snaplen for the tcpdump...

Here's a pcap dump file of the transaction.  I changed [rw]size to 1024
because I couldn't work out how to get ethereal to reassemble the
fragments.  It doesn't seem to have affected the behaviour at all.

This was with a 2.5.47 client (same server as before).

        J

--=-d/ocxyxY5hacsrgsFMfn
Content-Disposition: attachment; filename=nfs-htree.pcap.gz
Content-Type: application/x-gzip; name=nfs-htree.pcap.gz
Content-Transfer-Encoding: base64

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

--=-d/ocxyxY5hacsrgsFMfn--

