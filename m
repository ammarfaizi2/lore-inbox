Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269461AbTCDOD3>; Tue, 4 Mar 2003 09:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269462AbTCDOD3>; Tue, 4 Mar 2003 09:03:29 -0500
Received: from dp.samba.org ([66.70.73.150]:61831 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269461AbTCDOD2>;
	Tue, 4 Mar 2003 09:03:28 -0500
Date: Wed, 5 Mar 2003 01:13:25 +1100
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Message-ID: <20030304141324.GA12185@krispykreme>
References: <103200000.1046755559@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103200000.1046755559@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, so I finally took the plunge, and put 2.5 on my main desktop as well as
> just the lab machines ;-)
> 
> Generally seems to work very well, and VM performance is much more stable
> than 2.4 ... but xmms seems to skip if I just waggle the scrollbar in some
> windows. This happens most in my email client (which is Mulberry), but
> other things show it to a more limited extent.
> 
> The audio pauses happen on a simple window scroll down, without intensive
> CPU background activity ... they're very short in duration, which makes it
> *feel* more like the audio buffer is too small than a scheduler problem,
> but I'm just guessing really.

Are you running debian? It likes to nice -10 the X server. Renicing it
back to 0 fixes my xmms skips with 2.5.

Anton
