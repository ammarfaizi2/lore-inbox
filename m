Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129226AbQK0Sk6>; Mon, 27 Nov 2000 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129289AbQK0Sks>; Mon, 27 Nov 2000 13:40:48 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:57852 "HELO
        matrix.mandrakesoft.com") by vger.kernel.org with SMTP
        id <S129226AbQK0Skl>; Mon, 27 Nov 2000 13:40:41 -0500
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Mandrake Install <install@linux-mandrake.com>
Subject: Re: Universal debug macros.
In-Reply-To: <200011270045.BAA13121@cave.bitwizard.nl>
        <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
        <8vsno2$pc6$1@cesium.transmeta.com>
        <m3vgt9nykk.fsf@matrix.mandrakesoft.com>
        <3A229E41.B3C278E2@transmeta.com>
        <m3aealnvt6.fsf@matrix.mandrakesoft.com>
        <3A22A0C9.6888B08@transmeta.com>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 27 Nov 2000 19:10:35 +0100
In-Reply-To: <3A22A0C9.6888B08@transmeta.com>
Message-ID: <m366l9nv50.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@transmeta.com> writes:

> It's not that slow compared to a whole distro install, although you would
> of course want to do it *optionally*.  

that would be for sure, but keep in mind by experiences most people
sent us a /lot/ of bug reports because they don't know how to do even
if we wrote (IT IS ONLY FOR EXPERIENCED PEOPLE). Let say a scenario :

dumb^Hjoe user make a expert install even if he don't have any clue
about what is a kernel or a compiler or even drivers (yep we have some
users like this)
joe user choose to compile kernel
click on everything (sound fun all this checkboxes)
choose to reboot on his kernel (this sound too cook he can make some
uname -r on IRC to show ''his'' kernel)
reboot and sure he put some idiotic options like IDE in modules.

as i said it's a very special case but we have so much strangness in
our buisness...

You may say  that don't let the user choose the wrong option (ie:
don't let to choose to put IDE as modules when he has installed on an
only IDE partition), but there is too much case to handle...

> You wouldn't want to get into every single option, of course, but I

what do you purpose of something else of every single of options ?

> thought that was obvious (apparently not.)  The drivers and stuff is
> the least of the problem -- there, you can use modules anyway.

sorry i don't see the point, but indeed it could be doable if the
story of joe user didn't exist.


-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
