Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288950AbSA2IiT>; Tue, 29 Jan 2002 03:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288951AbSA2IiK>; Tue, 29 Jan 2002 03:38:10 -0500
Received: from sun.fadata.bg ([80.72.64.67]:60422 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S288950AbSA2Ih4>;
	Tue, 29 Jan 2002 03:37:56 -0500
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
Date: 29 Jan 2002 10:39:12 +0200
Message-ID: <87lmehft5b.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Oliver" == Oliver Xymoron <oxymoron@waste.org> writes:
Oliver> you can't actually _share_ the page tables without marking the pages
Oliver> themselves readonly.

Of course, ptes are made COW, just like now. Which brings up the
question how much speedup we'll gain with a code that touches every
single pte anyway ?
