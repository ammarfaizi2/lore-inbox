Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281170AbRKOXSb>; Thu, 15 Nov 2001 18:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281166AbRKOXSL>; Thu, 15 Nov 2001 18:18:11 -0500
Received: from erasmus.off.net ([64.39.30.25]:3336 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S281162AbRKOXSA>;
	Thu, 15 Nov 2001 18:18:00 -0500
Date: Thu, 15 Nov 2001 18:18:01 -0500
From: Zach Brown <zab@zabbo.net>
To: J Sloan <jjs@toyota.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Hood <jdthood@mail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: CS423x audio driver updates for testing
Message-ID: <20011115181801.N6462@erasmus.off.net>
In-Reply-To: <E164QJM-0000y2-00@the-village.bc.nu> <3BF40D3C.8D3F0369@lexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF40D3C.8D3F0369@lexus.com>; from jjs@toyota.com on Thu, Nov 15, 2001 at 10:45:16AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I seem to remember, folks intererested in gaming and
> mulitmedia apps had done some latency profiling and
> found that the alsa drivers were a source of really bad
> latency - am I imagining all this or does it ring a bell
> with someone?

Thats the sort of thing that can be fixed as ALSA is merged, I would
hope.

ALSA is much, much, closer to a nice kernel sound driver setup than the
current OSS code base.  It has problems, yes, but a good attack during
2.5 should iron out the worst of it.  There just needs to be an
understanding up front that the ALSA as initially merged may see
significant changes to get rid of some of the 'non-kernel friendly'
code.  (in-kernel mixing, some interesting naming, over-abstraction in
places, gratuitious wrapping of kernel functions.. all should be
candidates for early removal, IMHO)

but, really, I spend next to 0 time on sound stuff these tdays, so take
all of this with about 7 tons of salt.

- z
