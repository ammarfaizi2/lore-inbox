Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVASRUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVASRUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVASRPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:15:34 -0500
Received: from mail.tmr.com ([216.238.38.203]:52750 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261785AbVASROm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:14:42 -0500
Date: Wed, 19 Jan 2005 12:03:44 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dan Hollis <goemon@anime.net>
cc: Venkat Manakkal <venkat@rayservers.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jari Ruusu <jariruusu@users.sourceforge.net>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Paul Walker <paul@black-sun.demon.co.uk>, linux-kernel@vger.kernel.org,
       linux-crypto@nl.linux.org, James Morris <jmorris@redhat.com>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
In-Reply-To: <Pine.LNX.4.44.0501181616090.15507-100000@sasami.anime.net>
Message-ID: <Pine.LNX.3.96.1050119115600.8036H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Dan Hollis wrote:

> On Tue, 18 Jan 2005, Venkat Manakkal wrote:
> > As for cryptoloop, I'm sorry, I cannot say the same. The password hashing
> > system being changed in the past year, poor stability and machine lockups are
> > what I have noticed, besides there is nothing like the readme here:
> 
> cryptoloop is also unusably slow, even on my x86_64 machines...

I'm obviously doing something wrong, I just copied about 40MB of old
kernels (vmlinuz*) and some jpg files into a subdir on my cryptoloop
filesystem, and I measured 4252.2375kB/s realtime and 18819.7879 kB/s CPU
time. This doesn't seem unusably slow, even on my mighty P-II/350 and
eight year old 4GB drives. The hdb is so old it has to run in pio mode, to
give you an idea, and the original data was not in memory.

Undoubtedly your idea of unusably slow is far more demanding than mine...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

