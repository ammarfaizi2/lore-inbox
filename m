Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRGNQ7B>; Sat, 14 Jul 2001 12:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263927AbRGNQ6v>; Sat, 14 Jul 2001 12:58:51 -0400
Received: from weta.f00f.org ([203.167.249.89]:28291 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S263918AbRGNQ6k>;
	Sat, 14 Jul 2001 12:58:40 -0400
Date: Sun, 15 Jul 2001 04:58:42 +1200
From: Chris Wedgwood <cw@f00f.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
Message-ID: <20010715045842.B6963@weta.f00f.org>
In-Reply-To: <20010715031815.D6722@weta.f00f.org> <200107141414.f6EEEjQ05792@ns.caldera.de> <17573.995129225@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17573.995129225@redhat.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 05:47:05PM +0100, David Woodhouse wrote:

    Doing that in the middle of a supposedly stable series, even if it wasn't a 
    fundamentally stupid thing to do in the first place, isn't really very 
    sensible.

If it changes vmlinux by a single byte, I might agree.... all it does
is close off and older depricated API.

Anyhow, say we leave linux/malloc.h for external module authors, but
make the other changes?

I'll re-run the script I wrote duing 2.5.x when we do remove malloc.h
to catch anything left over.

Does that sound reasonable?



  --cw
