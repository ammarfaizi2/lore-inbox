Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284464AbRLXHZZ>; Mon, 24 Dec 2001 02:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284472AbRLXHZO>; Mon, 24 Dec 2001 02:25:14 -0500
Received: from mailg.telia.com ([194.22.194.26]:21975 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S284464AbRLXHY5>;
	Mon, 24 Dec 2001 02:24:57 -0500
To: rct@gherkin.frus.com (Bob_Tracy)
Cc: Peter Osterlund <petero2@telia.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
In-Reply-To: <m16IMMg-0005khC@gherkin.frus.com>
From: Peter Osterlund <petero2@telia.com>
Date: 24 Dec 2001 08:24:01 +0100
In-Reply-To: <m16IMMg-0005khC@gherkin.frus.com>
Message-ID: <m24rmhozce.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rct@gherkin.frus.com (Bob_Tracy) writes:

> Peter Osterlund wrote:
> > So, what changes are needed to make CD support work?
> 
> Evidently non-trivial...  I tried a quick hack at putting the
> sr_scatter_pad() code back into sr.c, but without success: null
> pointer dereference when I tried to mount an ISO9660 CD.

I also tried this, and it did get me a little further, but then I ran
into the problem with usb-storage that Greg KH mentioned.

> I think I'll enjoy the holiday week and wait for Jens to produce the
> proper fix :-).

I was hoping to be able to start testing my rewritten pktcdvd.o (CDRW
packet writing) module, but unfortunately I can't start until I get
standard USB CDROM support working.

-- 
Peter Österlund             petero2@telia.com
Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
S-128 66 Sköndal            +46 8 942647
Sweden
