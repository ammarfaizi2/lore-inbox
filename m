Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBGSan>; Wed, 7 Feb 2001 13:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129877AbRBGSad>; Wed, 7 Feb 2001 13:30:33 -0500
Received: from ns.caldera.de ([212.34.180.1]:10506 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129047AbRBGSaW>;
	Wed, 7 Feb 2001 13:30:22 -0500
Date: Wed, 7 Feb 2001 19:27:36 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207192736.B23859@caldera.de>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ben LaHaise <bcrl@redhat.com>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Steve Lord <lord@sgi.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	kiobuf-io-devel@lists.sourceforge.net,
	Ingo Molnar <mingo@redhat.com>
In-Reply-To: <20010206212503.A5426@caldera.de> <Pine.LNX.4.30.0102062132250.10016-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0102062132250.10016-100000@elte.hu>; from mingo@elte.hu on Tue, Feb 06, 2001 at 09:35:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 09:35:58PM +0100, Ingo Molnar wrote:
> caching bmap() blocks was a recent addition around 2.3.20, and i suggested
> some time ago to cache pagecache blocks via explicit entries in struct
> page. That would be one solution - but it creates overhead.
> 
> but there isnt anything wrong with having the bhs around to cache blocks -
> think of it as a 'cached and recycled IO buffer entry, with the block
> information cached'.

I was not talking about caching physical blocks but the remaining
buffer-cache support stuff.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
