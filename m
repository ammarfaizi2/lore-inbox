Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131605AbQLIWMx>; Sat, 9 Dec 2000 17:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132203AbQLIWMo>; Sat, 9 Dec 2000 17:12:44 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:52216 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131605AbQLIWM3>; Sat, 9 Dec 2000 17:12:29 -0500
Date: Sat, 9 Dec 2000 19:41:54 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swapoff weird
In-Reply-To: <20001209222427.A1542@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0012091941170.19389-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Pavel Machek wrote:

> It is possible to remove swapfile in use. Great, but how do you
> swap off then? Who is to blame?

As usual, root is to blame ;)

> root@bug:~# swapoff /tmp/swap
> swapoff: /tmp/swap: No such file or directory
> root@bug:~# > /tmp/swap
> root@bug:~# swapoff /tmp/swap
> swapoff: /tmp/swap: Invalid argument
> root@bug:~#

Don't let your automatic /tmp cleaners remove the swap
file ;)

> How do I get out of this bad situation?

Reboot.

cheers,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
