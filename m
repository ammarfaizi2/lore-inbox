Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130518AbQKGMv2>; Tue, 7 Nov 2000 07:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130435AbQKGMvT>; Tue, 7 Nov 2000 07:51:19 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:54010 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129926AbQKGMvN>; Tue, 7 Nov 2000 07:51:13 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jas88@cam.ac.uk (James A. Sutherland)
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 12:49:19 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jas88@cam.ac.uk (James A. Sutherland),
        goemon@anime.net (Dan Hollis), dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <E13t7yE-0007MV-00@the-village.bc.nu>
In-Reply-To: <E13t7yE-0007MV-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <00110712495300.01753@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000, Alan Cox wrote:
> > In the NIC example, I might well want the DHCP client to run whenever I
> > activate the card. Bringing the NIC up with the old configuration - which, with
> > dynamic IP addresses, could now include someone else's IP address! - is worse
> > than useless.
> 
> You'll notice the pcmcia subsystem already handles this, and keeps data in user
> space although it doesnt support saving it back. And it all works
> 
> In your case it would be something like
> 
> eth0	pegasus
> nopersist eth0
> post-install eth0 /usr/local/sbin/my-dhcp-stuff

So, in short, this is already done perfectly well in userspace without some
sort of Registry-style kernelside hack?


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
