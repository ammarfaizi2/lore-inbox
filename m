Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289216AbSAGOYu>; Mon, 7 Jan 2002 09:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289215AbSAGOYk>; Mon, 7 Jan 2002 09:24:40 -0500
Received: from ns.ithnet.com ([217.64.64.10]:54276 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289214AbSAGOY1>;
	Mon, 7 Jan 2002 09:24:27 -0500
Date: Mon, 7 Jan 2002 15:24:22 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Phil Oester" <kernel@theoesters.com>
Cc: nknight@pocketinet.com, linux-kernel@vger.kernel.org
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Message-Id: <20020107152422.42cfb554.skraw@ithnet.com>
In-Reply-To: <000101c19743$a6dc4120$6400a8c0@philxp>
In-Reply-To: <20020105161727.18f04fc3.skraw@ithnet.com>
	<000101c19743$a6dc4120$6400a8c0@philxp>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002 22:22:16 -0800
"Phil Oester" <kernel@theoesters.com> wrote:

> I've rerun this test a number of times, and cannot reliably reproduce
> the OOM - though it still does OOM occasionally.  It never OOM's right
> after a bootup - usually the greatest chance of OOM is after 2 or 3
> consecutive runs without a reboot.  Once it even froze the box and
> required a powercycle.
> 
> I'm surprised you cannot OOM with 1gb RAM/256MB swap, as sometimes I'm
> over 900MB in swap - did you try consecutive runs, or just once and then
> reboot between each run?

I tried just about everything I could think of and it never went in OOM. Even
the first test I did were with several days uptime - meaning far away from
"cleaning" reboot. I hate reboot :-)

> [...]
> Haven't yet tried Martin's patch - though since I can't reliably produce
> the OOM, testing it wouldn't help much.

Well, take the other side: if you do not manage to OOM afterwards, even at the
tenth consecutive try, there is probably something about the patch ...

Regards,
Stephan

