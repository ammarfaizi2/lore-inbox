Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbSJTW3U>; Sun, 20 Oct 2002 18:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSJTW3U>; Sun, 20 Oct 2002 18:29:20 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:34268 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264652AbSJTW3T>; Sun, 20 Oct 2002 18:29:19 -0400
Date: Sun, 20 Oct 2002 20:35:07 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] procps 3.0.4
In-Reply-To: <200210200353.g9K3rEF341645@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44L.0210202032590.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Albert D. Cahalan wrote:

> > Can you be more specific?  What bugs do you see?

> There isn't error checking in the five_cpu_numbers function
> to detect bad data. Not that bad data should ever happen; there
> is a bug in the WOLK kernel.

Guess why the iowait stats are initialised to 0 ? ;)

We know that user, system, nice and idle are present
in every kernel and we bail out with an error if we
get less than 4 values for the CPU stats.

> I could make vmstat way faster if the kernel would provide the
> number of tasks that are running, swapped out, blocked, etc.

I sent in a patch for that. I'll resend when Linus returns
from holidays.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

