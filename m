Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293169AbSBWS2e>; Sat, 23 Feb 2002 13:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293170AbSBWS2Y>; Sat, 23 Feb 2002 13:28:24 -0500
Received: from bitmover.com ([192.132.92.2]:30880 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293169AbSBWS2G>;
	Sat, 23 Feb 2002 13:28:06 -0500
Date: Sat, 23 Feb 2002 10:28:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020223102805.F11156@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
	Matthew Kirkwood <matthew@hairy.beasts.org>,
	Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202231551300.4173-100000@localhost.localdomain> <Pine.LNX.4.33.0202231017310.9185-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202231017310.9185-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Feb 23, 2002 at 10:20:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, one thing possibly worth looking into is to just put the actual
> semaphore contents into a regular file backed setup.
> 
> 		Linus

Exactly.  SMP gives you coherent memory and test-and-set or some other
atomic operation.  Why not use it?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
