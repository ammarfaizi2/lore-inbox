Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319794AbSIMV2a>; Fri, 13 Sep 2002 17:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319796AbSIMV2a>; Fri, 13 Sep 2002 17:28:30 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:42645 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319794AbSIMV23>; Fri, 13 Sep 2002 17:28:29 -0400
Date: Fri, 13 Sep 2002 18:33:04 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
In-Reply-To: <20020913212921.GA17627@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44L.0209131830560.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Pavel Machek wrote:

> Allocating memory is pain because I have to free it afterwards. Yep I
> have such code, but it is ugly. try_to_free_pages() really seems like
> cleaner solution to me... if you only tell me how to fix it :-).

"Fixing" the VM just so it behaves the way swsuspend wants is
out. If swsuspend relies on all other subsystems playing nicely,
I think it should be removed from the kernel.

I suspect only very few people will use swsuspend, so it should
not be intrusive.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

