Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRBCUVp>; Sat, 3 Feb 2001 15:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRBCUVj>; Sat, 3 Feb 2001 15:21:39 -0500
Received: from jalon.able.es ([212.97.163.2]:36594 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129454AbRBCUVT>;
	Sat, 3 Feb 2001 15:21:19 -0500
Date: Sat, 3 Feb 2001 11:00:53 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: David Ford <david@linux.com>
Cc: unlisted-recipients@vger.kernel.org,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010203110053.C1766@werewolf.able.es>
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu> <3A7BC808.E9BF5B44@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A7BC808.E9BF5B44@linux.com>; from david@linux.com on Sat, Feb 03, 2001 at 09:57:45 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.03 David Ford wrote:
> How about a simple patch to the top level makefile that checks the gcc
> version then prints a distinct message ..'this compiler hasn't been approved
> for compiling the kernel', sleeping for one second, then continuing on.  This
> solution doesn't stop compiling and makes a visible indicator without forcing
> anything.
> 

Or a config option like CONFIG_TRUSTED_COMPILER, and everyone that wants
can bracket his code in 'if [ $TRUSTED = "y" ] ... fi', so if some driver-fs
fails with untrusted compilers it is just not selectable.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac1 #2 SMP Fri Feb 2 00:19:04 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
