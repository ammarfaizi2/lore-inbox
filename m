Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131418AbQKAUyE>; Wed, 1 Nov 2000 15:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131591AbQKAUxy>; Wed, 1 Nov 2000 15:53:54 -0500
Received: from smtp-abo-1.wanadoo.fr ([193.252.19.122]:21697 "EHLO
	villosa.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S131590AbQKAUxm>; Wed, 1 Nov 2000 15:53:42 -0500
Date: Wed, 1 Nov 2000 22:03:27 +0100
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001101220326.A4514@bylbo.nowhere.earth>
In-Reply-To: <20001101174816.A18510@athlon.random> <Pine.LNX.4.21.0011011456430.11112-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011011456430.11112-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Nov 01, 2000 at 02:59:01PM -0200
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 02:59:01PM -0200, Rik van Riel wrote:

Andrea wrote:
> (btw, make sure you're using the -7 revision of the VM-global patch, as it
> includes the same MM corruption bugfix that is been included into 18pre18)

Damn, I was using -6.  http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre9/ does not have -7.
Neither does your e-mind repository hlinked from linux-mm.

I'm currently running -6 :(


On Wed, Nov 01, 2000 at 02:59:01PM -0200, Rik van Riel wrote:
> it appears there has been amazingly little research on this
> subject and it's completely unknown which approach will work
> "best" ... or even, what kind of behaviour is considered to
> be best by the users...

Sounds to me like a good point to favour a config-time selection of
OOM killers.


> On Wed, 1 Nov 2000, Andrea Arcangeli wrote:
> > Fair enough as there isn't an oom killer in the kernel you're
> > running :). So it can kill unlucky tasks as well.
> 
> There's a (slightly outdated?) patch available on my home
> page, though...

Found http://www.surriel.com/patches/2.2.17pre8-oomkill.  Will take a
look, thanks.


> Not because I think it matters all that much on most systems
> (good admins put in enough memory&swap), but simply because

Ah, I'll have to reconsider how much I rate my skills :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
debian-email:   <dirson@debian.org> |   Support Debian GNU/Linux:
                                    | Cheaper, more Powerful, more Stable !
http://ydirson.free.fr/             | Check <http://www.debian.org/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
