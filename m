Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbRAELsA>; Fri, 5 Jan 2001 06:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAELru>; Fri, 5 Jan 2001 06:47:50 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:26608 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129873AbRAELrh>; Fri, 5 Jan 2001 06:47:37 -0500
Date: Fri, 5 Jan 2001 09:46:46 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Nicholas Knight <tegeran@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
In-Reply-To: <002201c076c7$76cab720$8d19b018@c779218a>
Message-ID: <Pine.LNX.4.21.0101050944450.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Nicholas Knight wrote:

> While I understand the reasoning behind this, and might do the
> same thing if I was in your position, I feel it may be a
> mistake. I personaly do not trust the 2.4.x kernel entirely yet,
> and would prefer to wait for 2.4.1 or 2.4.2 before upgrading
> from 2.2.18 to ensure last-minute wrinkles have been completely
> ironed out,

This is *exactly* why Alan's policy change makes sense.

If somebody submits a driver bugfix or update for 2.2,
but not for 2.4, it'll take FOREVER for 2.4 to become
as "trustable" as 2.2...

This change, however, will make sure that 2.4 will be
as reliable as 2.2 much faster. Unlike 2.2, the core
kernel of 2.4 is reliable ... only the peripheral stuff
like drivers may be out of date or missing.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
