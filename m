Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSEAKvk>; Wed, 1 May 2002 06:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSEAKvj>; Wed, 1 May 2002 06:51:39 -0400
Received: from zork.zork.net ([66.92.188.166]:15374 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S293510AbSEAKvi>;
	Wed, 1 May 2002 06:51:38 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: How to tune vm to be less swap happy?
In-Reply-To: <200205011202.38653.aaime@libero.it>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Message-Flag: Message text advisory: STARKISM(S), ADULT
 LANGUAGE/SITUATIONS
X-Mailer: Norman
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Wed, 01 May 2002 11:51:37 +0100
Message-ID: <6uofg0uona.fsf@zork.zork.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Andrea Aime quotation:

> sorry to bother you with this question, but I feel that current vm
> defaults are not tuned for a workstation use, but for a file
> server/db server use.
> [...] is there anything I can do to shrink the cache and to allow a
> bigger part of my working set to fit into memory? Moreover, what vm
> tuning do you advice for a typical workstation use with memory
> hungry applications?

I've found the rmap VM[0] to be a lot less swap-happy than the stock
VM.  For example, I don't come in in the morning to find that the
updatedb run has pushed everything into swap and bloated the inode and
dentry caches to ridiculous sizes.  There is also a patch around for
the stock VM, but I haven't tried it and I don't know what it does.

[0] http://www.surriel.com/patches/  -- I used the March 1 patch on
    2.4.18 and am now running with the April 9 patch.

-- 
 /////////////////  |                  | The spark of a pin
<sneakums@zork.net> |  (require 'gnu)  | dropping, falling feather-like.
 \\\\\\\\\\\\\\\\\  |                  | There is too much noise.
