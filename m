Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQKFVxH>; Mon, 6 Nov 2000 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbQKFVwp>; Mon, 6 Nov 2000 16:52:45 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:8708 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129383AbQKFVwg>; Mon, 6 Nov 2000 16:52:36 -0500
Message-ID: <3A07272B.91DBB82F@timpanogas.org>
Date: Mon, 06 Nov 2000 14:48:27 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Yann Dirson <ydirson@altern.org>
CC: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine 
 hangs)
In-Reply-To: <20001101174816.A18510@athlon.random> <Pine.LNX.4.21.0011011456430.11112-100000@duckman.distro.conectiva> <20001101220326.A4514@bylbo.nowhere.earth> <20001101220002.A17134@athlon.random> <20001106225606.A31175@bylbo.nowhere.earth>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Yann Dirson wrote:
> 
> Nov  5 22:36:17 bylbo nscd: 925: while accepting connection: Cannot allocate memory
> 
> They usually appear at cron.daily time, although it looks like I kinda can
> reproduce them.  I'm still investigating and narrowing - they seem to avoid
> me unfortunately :(  Will launch a tracking job for the night, hopefully
> I'll narrow to the single cron job this time.
> 
> Anyone seen that ?

I see it with sendmail all the time when the fs gets really busy, and
memory gets low in 
box. 

Thanks

Jeff

> 
> > After applying the patch you should make sure there are no rejects with a `find
> > -name \*.rej`.  If there aren't rejects all gone right.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
