Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135505AbRANVoq>; Sun, 14 Jan 2001 16:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135533AbRANVog>; Sun, 14 Jan 2001 16:44:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2317 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135505AbRANVoY>; Sun, 14 Jan 2001 16:44:24 -0500
Date: Sun, 14 Jan 2001 13:44:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.30.0101142136330.4111-100000@e2>
Message-ID: <Pine.LNX.4.10.10101141341570.4505-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jan 2001, Ingo Molnar wrote:
> 
> There is a Samba patch as well that makes it sendfile() based. Various
> other projects use it too (phttpd for example), some FTP servers i
> believe, and khttpd and TUX.

At least khttpd uses "do_generic_file_read()", not sendfile per se. I
assume TUX does too. Sendfile itself is mainly only useful from user
space..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
