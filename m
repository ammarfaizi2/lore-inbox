Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292550AbSBPVmO>; Sat, 16 Feb 2002 16:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292551AbSBPVmF>; Sat, 16 Feb 2002 16:42:05 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:49161 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292550AbSBPVlw>;
	Sat, 16 Feb 2002 16:41:52 -0500
Date: Sat, 16 Feb 2002 19:41:31 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: future of rmap VM
In-Reply-To: <1013894969.1283.8.camel@tiger>
Message-ID: <Pine.LNX.4.33L.0202161938270.1930-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Feb 2002, Louis Garcia wrote:

> When do you plan to have a complete rmap VM ready for general use?
> Whats left to do?

Rmap version 11c is considered ready for use.

For rmap 12, which is also ready for use, I have added the
feature of RSS limit enforcement.

Rmap version 13 will get new page launder features.

It seems from now on -rmap will get new features, but no
more changes to the -rmap architecture are needed right
now.

> Also, have you discussed merging this VM into the mainline kernel,
> either 2.4 or 2.5?

I've started pushing some trivial stuff for inclusion into
2.5, but unfortunately current 2.5 just won't boot on my
test box so I cannot test it (either with or without the
patch).

Once 2.5 is working on my test box, I'll be ready to merge
some of the larger stuff ...

... I'll try to push things to Linus in small parts, so
nothing will break in the process.

> To me, this VM is far better than the current VM.

Good to hear I've got happy users.

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

