Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRJEUNH>; Fri, 5 Oct 2001 16:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRJEUM5>; Fri, 5 Oct 2001 16:12:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271005AbRJEUMv>; Fri, 5 Oct 2001 16:12:51 -0400
Date: Fri, 5 Oct 2001 13:12:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: pre4 oom too soon
In-Reply-To: <Pine.LNX.4.21.0110051518110.2744-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0110051312200.2044-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually, it looks like the easiest solution is to just remove the

	cache_mem -= swapper_space.nrpages;

which should just automatically do the right thing.

		Linus

