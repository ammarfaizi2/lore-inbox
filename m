Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132771AbRANNNc>; Sun, 14 Jan 2001 08:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132696AbRANNNV>; Sun, 14 Jan 2001 08:13:21 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:28434 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S132702AbRANNNL>;
	Sun, 14 Jan 2001 08:13:11 -0500
Date: Sun, 14 Jan 2001 15:12:57 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-pre3+zerocopy: weird messages
Message-ID: <20010114151257.J1394@ppetru.net>
In-Reply-To: <20010114121105.B1394@ppetru.net> <14945.32886.671619.99921@pizda.ninka.net> <20010114124549.D1394@ppetru.net> <14945.34414.185794.396720@pizda.ninka.net> <20010114132845.F1394@ppetru.net> <14945.36440.59585.376942@pizda.ninka.net> <20010114141003.G1394@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <20010114141003.G1394@ppetru.net>; from ppetru@ppetru.net on Sun, Jan 14, 2001 at 02:10:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 02:10:03PM +0200, Petru Paler wrote:
> On Sun, Jan 14, 2001 at 03:32:40AM -0800, David S. Miller wrote:
> > Petru Paler writes:
> >  > > Oh, I think I know why this happens.  Can you add this patch, and next
> >  > > time the UDP bad csum message appears, tell me if it says "UDP packet
> >  > > with bad csum was fragmented." in the next line of your syslog
> >  > > messages?  Thanks.
> 
> Jan 14 06:54:08 grey kernel: Undo loss 193.230.129.57/34342 c2 l0 ss2/2 p0
> Jan 14 06:56:40 grey kernel: udp v4 hw csum failure.
> Jan 14 06:57:05 grey kernel: Undo partial loss 193.230.129.57/34342 c1 l5 ss2/3 p5        
> 
> So no "UDP packet with bad csum was fragmented" line. This is the first
> one though, will let you know if the fragmented thing occurs.

Got more "udp v4 hw csum failure" messages but still no "UDP packet with bad csum was fragmented".

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
