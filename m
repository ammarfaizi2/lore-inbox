Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264611AbRF3XS1>; Sat, 30 Jun 2001 19:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264635AbRF3XSS>; Sat, 30 Jun 2001 19:18:18 -0400
Received: from [212.159.14.227] ([212.159.14.227]:646 "HELO
	warrior-outbound.servers.plus.net") by vger.kernel.org with SMTP
	id <S264611AbRF3XSO>; Sat, 30 Jun 2001 19:18:14 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com>
From: Adam Sampson <azz@gnu.org>
Organization: The Society Of People Who Repeatedly Point Out That "alot" And "allot" Are Both Wrong, And It Should Be Written "a lot"
Date: 30 Jun 2001 23:17:50 +0100
In-Reply-To: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com>
Message-ID: <873d8h4nox.fsf@cartman.azz.us-lot.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> So let's simply disallow versions, author information, and "good status"
> messages, ok?

I'd be quite happy with this, if only for consistency's sake -- at the
moment we've got some kernel subsystems which print "yup, I've started
up" messages, and some which don't; it's mildly annoying when you're
trying to track down a problem that's stopping the kernel from
starting up correctly, because there's no guarantee that the last
message had anything to do with what was actually happening.

Being a geekish sort of person, I'd prefer it if on my system I could
make everything print a line saying what it is and what hardware it
found; perhaps it could be a kernel argument ("messages=full"; the
messages option would control which log prefixes printk would actually
print to the screen, and module startup messages would use a
predefined prefix). Might be handy for debugging.

-- 
Adam Sampson <azz@gnu.org>                  <URL:http://azz.us-lot.org/>
