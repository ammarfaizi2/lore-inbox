Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRAIILE>; Tue, 9 Jan 2001 03:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130642AbRAIIKr>; Tue, 9 Jan 2001 03:10:47 -0500
Received: from clueserver.org ([206.163.47.224]:37393 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S129401AbRAIIK1>;
	Tue, 9 Jan 2001 03:10:27 -0500
Date: Tue, 9 Jan 2001 00:20:17 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: J Sloan <jjs@toyota.com>
Cc: "Michael D. Crawford" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: [OT]: DRI doesn't work on 2.4.0 but does on prerelease-ac5
In-Reply-To: <3A5A4585.5036A11C@toyota.com>
Message-ID: <Pine.LNX.4.10.10101090017330.10661-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, J Sloan wrote:

> This is a little OT for linux-kernel, but I'll take a swing at it
> since I'm running 2.4 and Xfree 4 with a voodoo 3.
> 
> After upgrading to Red Hat 7.0, I noticed 3D screensavers
> and Quake 3 Arena were dog slow - in the end, I basically
> had to make sure the mesa libs didn't get found before the
> real opengl libs.
> 
> In my case, that meant nuking mesa from my system and
> letting Linux use what was left, which got me back the good
> accelerated performance - you may choose a less drastic
> option. I don't see any breakage from the absence of mesa.

Sounds like the version you blew away was not the one built in 4.0.2.
(Mesa is built along with XFree86 now, not as an add-on.)

I will test with my current configuration and see if I can duplicate the
slow down.

I am currently using a Matrox G400 max card with 4.0.2cvs.  I get about
1285 frames per second on the gears demo currently. We will see if that
changes with the 2.4.0 final release version.

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
