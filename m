Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTAJQ7p>; Fri, 10 Jan 2003 11:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTAJQ7p>; Fri, 10 Jan 2003 11:59:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61967 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265517AbTAJQ7o>; Fri, 10 Jan 2003 11:59:44 -0500
Date: Fri, 10 Jan 2003 09:03:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Richard Henderson <rth@twiddle.net>, Miles Bader <miles@gnu.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX
 is non-empty 
In-Reply-To: <20030110102144.4BE3C2C113@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301100902380.12833-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jan 2003, Rusty Russell wrote:
> 
> Yep.  Maximum length of obsolete parameter name in current kernel:
> seq_default_timer_resolution (28 chars).

Don't do this. Make the limit fixed, and check it.

		Linus

