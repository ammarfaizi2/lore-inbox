Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319142AbSIJOT1>; Tue, 10 Sep 2002 10:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319144AbSIJOT1>; Tue, 10 Sep 2002 10:19:27 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:32765
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319142AbSIJOT0>; Tue, 10 Sep 2002 10:19:26 -0400
Subject: Re: ignore pci devices?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020910134708.GA7836@bytesex.org>
References: <20020910134708.GA7836@bytesex.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 15:27:12 +0100
Message-Id: <1031668032.31549.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 14:47, Gerd Knorr wrote:
> I have a small problem:  Some vendor has built a PCI board which
> (ab-)uses the bt848/878 chip in creative ways to do some DMA.  It is
> *not* a video card, thus letting the bttv driver control the card isn't
> very useful and causes trouble.  The card has no PCI Subsystem ID, so I
> can't identify and blacklist it easily.  Thus I need some way to allow
> the users to tell bttv (or the kernel) to ignore that particular PCI
> card.

Doh.. If the vendor isnt setting subsystem ids then its not valid
hardware for windows nowdays. Obvious question - what else is on that
board that might let you do the idents. We already find the USB on the
NSC SuperIO by peeking at the next device along and checking if its the
SuperIO functions 8)

