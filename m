Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbQJ3TMn>; Mon, 30 Oct 2000 14:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbQJ3TMc>; Mon, 30 Oct 2000 14:12:32 -0500
Received: from anime.net ([63.172.78.150]:50186 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129026AbQJ3TM1>;
	Mon, 30 Oct 2000 14:12:27 -0500
Date: Mon, 30 Oct 2000 11:11:52 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030184109.C21935@athlon.random>
Message-ID: <Pine.LNX.4.21.0010301110450.12201-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Andrea Arcangeli wrote:
> TUX modules are kernel modules (I mean you have to write kernel space code for
> doing TUX ftp). Don't you agree that zero-copy sendfile like ftp serving would
> be able to perform equally well too?

For this to bw useful for ftp we need a sendfile() that can write from a
socket to a diskfile also.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
