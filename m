Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129754AbRB0Vw3>; Tue, 27 Feb 2001 16:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRB0VwT>; Tue, 27 Feb 2001 16:52:19 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:23046 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129754AbRB0VwI>;
	Tue, 27 Feb 2001 16:52:08 -0500
Date: Tue, 27 Feb 2001 16:52:09 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Mike Galbraith <mikeg@wen-online.de>
cc: <shawn@rhua.org>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Causes more then
 just  msgs
In-Reply-To: <Pine.LNX.4.33.0102271104320.927-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.30.0102271651290.7968-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When added with BUG(); it will hang /dev/dsp.

I'm not sure if it did without it. I'll be restarting with the removed
BUG(); soon.

On Tue, 27 Feb 2001, Mike Galbraith wrote:

> On Mon, 26 Feb 2001, Shawn Starr wrote:
>
> > It may not be an important message but what does happen is /dev/dsp becomes
> > hung and no sound works after the fault. So something is definately wrong.
>
> Do you mean it hangs without the BUG() inserted, or only after the oops?
>
> 	-Mike
>
>
>

