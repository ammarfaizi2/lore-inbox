Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSJHTuj>; Tue, 8 Oct 2002 15:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSJHTtd>; Tue, 8 Oct 2002 15:49:33 -0400
Received: from borg.org ([208.218.135.231]:5366 "HELO borg.org")
	by vger.kernel.org with SMTP id <S261526AbSJHTsf>;
	Tue, 8 Oct 2002 15:48:35 -0400
Date: Tue, 8 Oct 2002 15:54:15 -0400
From: Kent Borg <kentborg@borg.org>
To: linux-kernel@vger.kernel.org
Subject: Loading init and ld.so.1 for Coldfire V4e
Message-ID: <20021008155415.D9391@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get Linux working on a Coldfire V4e (no, they don't
exist yet in the outside world).  This is kind of an m68k, but being a
Coldfire, it is a subset of the old m68k.  This is a Coldfire, but
being new and spiffy, it has an MMU (32 instruction TLB entries, 32
data TLB entries). 

Currently I am at the point where a lot of the memory stuff is
possibly working, the kernel thinks it has booted, and it is trying to
fire up init.  And it is failing.

Does anyone have a pointer to something I can read to tell me a bit of
how programs load, what ld.so.1 does, etc?  I am in the midst of elf
headers, I see ld.so.1 being opened, I see sections with various
addresses flying by, and I end up trying to execute an address that is
not executable, only read-write.  It is possible that stuff really is
percolating correctly from vma's to page tables, it is possible stuff
really is percolating correctly from page tables to TLBs.  It is
possible that ld.so.1 and init really are being built correctly and
even at sensible addresses, but I don't know.  There are too many
variables here that I don't know about.

Any suggestions on where I could learn more on how init is supposed to
get up and running?


Thanks,

-kb, the Kent who happens to work for an obscure little corner of
Motorola.
