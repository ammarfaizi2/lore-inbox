Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbRGAFJT>; Sun, 1 Jul 2001 01:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264989AbRGAFJK>; Sun, 1 Jul 2001 01:09:10 -0400
Received: from lithium.nac.net ([64.21.52.68]:14351 "HELO lithium.nac.net")
	by vger.kernel.org with SMTP id <S264984AbRGAFIz>;
	Sun, 1 Jul 2001 01:08:55 -0400
Date: Sun, 1 Jul 2001 01:08:47 -0400
To: linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Freezing bug in all kernels greater than 2.4.5-ac13 *AND* 2.4.6-pre2
Message-ID: <20010701010846.A685@debian>
In-Reply-To: <20010623222954.A9031@debian> <20010627203331.B1615@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010627203331.B1615@debian>
User-Agent: Mutt/1.3.18i
From: <tcm@nac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm currently running 2.4.6-pre8 and happy as a clam, the
problem has been found and reverted, looks from my discussions with
Linus like the page_launder change introduced into pre3 and also
included in ac14 was causing the hangs/near freezes.

	I'm not really much of a coder, so I can't say what was wrong
with it, only what the symptoms were and how to get it to screw up
whenever I wanted to test for it. (See previous messages for how to do
this) If Rik van Riel/Marcelo Tosatti/anyone wants to have me gather
information on what is going on just before/after the kernel dies I'll
do it - just tell me how to, and I'll push it along :)

Thanks a bunch Linus,
Tim
