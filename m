Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUDJV2S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 17:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUDJV2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 17:28:18 -0400
Received: from meyering.net1.nerim.net ([62.212.115.149]:2707 "EHLO
	elf.meyering.net") by vger.kernel.org with ESMTP id S262129AbUDJV2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 17:28:16 -0400
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       bug-coreutils@gnu.org, linux-kernel@vger.kernel.org,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: dd PATCH: add conv=direct
In-Reply-To: <20040409014244.GO20863@ca-server1.us.oracle.com> (Wim Coekaerts's message of "Thu, 8 Apr 2004 18:42:44 -0700")
References: <20040406220358.GE4828@hexapodia.org>
	<20040406173326.0fbb9d7a.akpm@osdl.org>
	<20040407173116.GB2814@hexapodia.org>
	<20040407111841.78ae0021.akpm@osdl.org>
	<20040407192432.GD2814@hexapodia.org>
	<20040407123455.0de9ffa9.akpm@osdl.org>
	<20040407194727.GE2814@hexapodia.org>
	<20040409003737.GF18493@krispykreme>
	<20040409014244.GO20863@ca-server1.us.oracle.com>
From: Jim Meyering <jim@meyering.net>
Date: Sat, 10 Apr 2004 23:28:16 +0200
Message-ID: <85ekqvmsjz.fsf@pi.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim Coekaerts <wim.coekaerts@oracle.com> wrote:
> philip copeland did a whole set of patches for coreutils to allow
> directio for both read write and mixed sizes even
> the rpm is at
> http://oss.oracle.com/projects/ocfs/files/source/RHAT/RHAS3/coreutils-4.5.3-33.src.rpm,

Thanks for the pointer.
FYI, that URL didn't work for me.  This one did:

http://oss.oracle.com/projects/ocfs/dist/files/source/RHAT/RHAS3/coreutils-4.5.3-33.src.rpm

Whoever maintains that code should consider merging their changes with
something newer.  There are over 500 lines of NEWS entries alone for the
coreutils releases that have been made since 4.5.3.

Besides, those patches have portability and robustness problems,
and they aren't even based on coreutils-4.5.3.  Maybe they're
based on some vendor's version of coreutils?

> I think he took it up with the maintainers but so far had no luck

As far as I know, no one ever submitted such O_DIRECT-based patches
to me or any of the bug-*@gnu.org mailing lists.

The only pending O_DIRECT-based patch is one for shred.

Clean, complete, and well-justified patches usually go in pretty quickly.
