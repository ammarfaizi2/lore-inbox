Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318761AbSHQWOx>; Sat, 17 Aug 2002 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318762AbSHQWOx>; Sat, 17 Aug 2002 18:14:53 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:19431 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318761AbSHQWOw>; Sat, 17 Aug 2002 18:14:52 -0400
Date: Sat, 17 Aug 2002 23:18:33 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
Message-ID: <20020817231833.A5804@kushida.apsleyroad.org>
References: <Pine.LNX.4.44.0208161033090.3193-100000@home.transmeta.com> <Pine.LNX.4.44.0208172044540.16707-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208172044540.16707-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Aug 17, 2002 at 08:48:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yay! [ ;) ]

Just a note: I recall that Linus suggested the optimisation of checking
mm->mm_count > 1, but Ingo is right to not include this -- it's possible
for the tid word to be stored in shared memory.

-- Jamie
