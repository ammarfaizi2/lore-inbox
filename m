Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbQKGX1k>; Tue, 7 Nov 2000 18:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbQKGX1a>; Tue, 7 Nov 2000 18:27:30 -0500
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:27056 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130187AbQKGX1U>; Tue, 7 Nov 2000 18:27:20 -0500
Date: Tue, 7 Nov 2000 21:48:08 +0100
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Yann Dirson <ydirson@altern.org>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001107214808.A26926@bylbo.nowhere.earth>
In-Reply-To: <20001101174816.A18510@athlon.random> <Pine.LNX.4.21.0011011456430.11112-100000@duckman.distro.conectiva> <20001101220326.A4514@bylbo.nowhere.earth> <20001101220002.A17134@athlon.random> <20001106225606.A31175@bylbo.nowhere.earth> <3A07272B.91DBB82F@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A07272B.91DBB82F@timpanogas.org>; from jmerkey@timpanogas.org on Mon, Nov 06, 2000 at 02:48:27PM -0700
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 02:48:27PM -0700, Jeff V. Merkey wrote:
> Yann Dirson wrote:
> > Nov  5 22:36:17 bylbo nscd: 925: while accepting connection: Cannot allocate memory
> > 
> > They usually appear at cron.daily time, although it looks like I kinda can
> > reproduce them.  I'm still investigating and narrowing - they seem to avoid
> > me unfortunately :(  Will launch a tracking job for the night, hopefully
> > I'll narrow to the single cron job this time.

Hm... 12h non-stop looping on the cron jobs and nothing in the logs.

Heisenbug :}


> > Anyone seen that ?
> 
> I see it with sendmail all the time when the fs gets really busy, and
> memory gets low in 
> box. 

But if your memory gets low it seems at least less anormal...  In my case it
occured at night when only the cron job was running.

-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
debian-email:   <dirson@debian.org> |   Support Debian GNU/Linux:
                                    | Cheaper, more Powerful, more Stable !
http://ydirson.free.fr/             | Check <http://www.debian.org/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
