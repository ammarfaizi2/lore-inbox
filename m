Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319297AbSHGTpl>; Wed, 7 Aug 2002 15:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319298AbSHGTpl>; Wed, 7 Aug 2002 15:45:41 -0400
Received: from 12-235-88-76.client.attbi.com ([12.235.88.76]:61709 "EHLO
	mail.wine.dyndns.org") by vger.kernel.org with ESMTP
	id <S319297AbSHGTpl>; Wed, 7 Aug 2002 15:45:41 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.30-A1
References: <Pine.LNX.4.44.0208072128460.26329-100000@localhost.localdomain>
From: Alexandre Julliard <julliard@winehq.com>
Date: 07 Aug 2002 12:49:11 -0700
In-Reply-To: <Pine.LNX.4.44.0208072128460.26329-100000@localhost.localdomain>
Message-ID: <87n0rylaa0.fsf@mail.wine.dyndns.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> i'll do this. Julliard, any additional suggestions perhaps - is GDT entry
> 8 the best %fs choice for Wine?

No, this one is special and has to point to 0x400, so it's actually
the only one that wouldn't work to use as %fs in Wine.

-- 
Alexandre Julliard
julliard@winehq.com
