Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263040AbTCLExh>; Tue, 11 Mar 2003 23:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263041AbTCLExh>; Tue, 11 Mar 2003 23:53:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2063 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263040AbTCLExh>; Tue, 11 Mar 2003 23:53:37 -0500
Date: Tue, 11 Mar 2003 21:02:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, <arnd@arndb.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
In-Reply-To: <20030312154413.40511744.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0303112055390.12728-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Stephen Rothwell wrote:
> 
> Linus, if Martin says this is OK, please apply.  This patch is relative
> to my previous patch, but applies to recent BK with some fuzz in the
> architectures that haven't merged my previous patch yet.

This is just too much CRAP, in my opinion. It's just unacceptably ugly,
and I don't think the compat layer is worth it if it just keeps on growing
barnacles that are as horrible as this.

Why do you have to shout in the code with macro names from hell? 

Make the code _look_ good. Not look like SOMEBODY WHO CANNOT TYPE WITHOUT
THE SHIFT KEY. Make the thing take properly typed arguments, instead of
casting stuff two ways and backwards inside macros.

			Linus

