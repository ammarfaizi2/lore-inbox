Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135285AbRAGDVV>; Sat, 6 Jan 2001 22:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135452AbRAGDVL>; Sat, 6 Jan 2001 22:21:11 -0500
Received: from clueserver.org ([206.163.47.224]:17425 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S135285AbRAGDVA>;
	Sat, 6 Jan 2001 22:21:00 -0500
Date: Sat, 6 Jan 2001 19:30:41 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
In-Reply-To: <3A57A83B.702CEC98@goingware.com>
Message-ID: <Pine.LNX.4.10.10101061928340.1843-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Michael D. Crawford wrote:

> AGP, VIA support, DRM, and r128 DRM are all compiled in statically rather than
> as modules.

AGPGART doe *not* work if compiled statically.  Compile it as a module.
You will be much happier. (i.e. It might actually work.)  I would also
compile DRM and the r128 drivers as modules as well.

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
