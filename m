Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314435AbSDRUex>; Thu, 18 Apr 2002 16:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSDRUew>; Thu, 18 Apr 2002 16:34:52 -0400
Received: from [195.39.17.254] ([195.39.17.254]:17037 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314435AbSDRUew>;
	Thu, 18 Apr 2002 16:34:52 -0400
Date: Thu, 18 Apr 2002 22:33:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Lang <david.lang@digitalinsight.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: eNBD on loopback [was Re: [PATCH] 2.5.8 IDE 36]
Message-ID: <20020418203304.GB1327@elf.ucw.cz>
In-Reply-To: <E16xVSi-0000FN-00@the-village.bc.nu> <Pine.LNX.4.33.0204160849540.1244-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Btw, while I'm at it - who out there actually uses the new "enbd"
> (Enhanced NBD)? I have this feeling that that would be the better choice,
> since unlike plain nbd it should be deadlock-free on localhost (ie you
> don't need a remote machine).

How does eNBD manage to do that? It was pretty hard last time I
checked...

What if their enbd server is swapped out, and all memory is in dirty
pages waiting for writeback to eNBD?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
