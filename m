Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266401AbRGBIJD>; Mon, 2 Jul 2001 04:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266402AbRGBIIx>; Mon, 2 Jul 2001 04:08:53 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:10503 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S266401AbRGBIIm>; Mon, 2 Jul 2001 04:08:42 -0400
Date: Mon, 2 Jul 2001 10:09:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jes Sorensen <jes@sunsite.dk>, "David S. Miller" <davem@redhat.com>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m achi ne
Message-ID: <20010702100919.B600@suse.de>
In-Reply-To: <d3u2109rho.fsf@lxplus015.cern.ch> <E15FkH1-0007l5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15FkH1-0007l5-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28 2001, Alan Cox wrote:
> We will also have to address those cards that have 28/30/31 bit limits (yes
> they exist) when we start doing direct I/O for 32bits of memory - one reason
> I'm very wary of Jens patch ever being in 2.4

The patch can handle those too, FWIW. The fact that it just sets 32-bit
limit now is unrelated, and it is also just set for devices that have
been sort-of tested :-)

Anyhoo, my point is that the bounce limit is variable on a page
granularity.

-- 
Jens Axboe
