Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSLBHbu>; Mon, 2 Dec 2002 02:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbSLBHbu>; Mon, 2 Dec 2002 02:31:50 -0500
Received: from are.twiddle.net ([64.81.246.98]:14996 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265587AbSLBHbt>;
	Mon, 2 Dec 2002 02:31:49 -0500
Date: Sun, 1 Dec 2002 23:39:01 -0800
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021201233901.B32203@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>, sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
	davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
	willy@debian.org
References: <Pine.LNX.4.44.0212011047440.12964-100000@home.transmeta.com> <1038804400.4411.4.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1038804400.4411.4.camel@rth.ninka.net>; from davem@redhat.com on Sun, Dec 01, 2002 at 08:46:40PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 08:46:40PM -0800, David S. Miller wrote:
> X86_64 on the other hand seems to run x86 binaries in a similar
> fashion.  I don't know how people currently doing this port intend
> to do the useland, but I bet it would benefit from a mostly 32-bit
> userland just like sparc64/ppc64 does, both in space and performance.

Except that x86-64 binaries get to use 16 more registers, can use
pc-relative addressing modes, and have a sane function calling
convention.  So things tend to run a bit faster in 64-bit mode.


r~
