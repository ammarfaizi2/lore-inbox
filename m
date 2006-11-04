Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965716AbWKDWWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965716AbWKDWWA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 17:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965721AbWKDWWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 17:22:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:10985 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965716AbWKDWV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 17:21:59 -0500
Date: Sat, 4 Nov 2006 22:21:56 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.34-pre5
Message-ID: <20061104222156.GA23518@hera.kernel.org>
Reply-To: Willy Tarreau <w@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

it has been a very calm month with very few patches and no serious
security problem, hence the lack of an earlier pre-release. Eventhough
there are very few fixes, I thought it was worth tagging another
pre-release for all those how don't use GIT.

We're close to an RC. I've just installed the RAM I ordered to upgrade
my Alpha, on which I will try to bring in support for gcc 4 (when gcc4
finally decides to build). If I manage to do it easily, I will add
another pre-release with it, otherwise I may release rc1 without it.

In the mean time, version 2.4.33.4 will follow shortly with some of
the small fixes below. If anyone encounters any problem, please
report it now. Same if you have unsent fixes you would like to see
merged.

Cheers,
Willy

--

Summary of changes from v2.4.34-pre4 to v2.4.34-pre5
============================================

Akinobu Mita (1):
      WATCHDOG: sc1200wdt.c pnp unregister fix.

Dick Streefland (1):
      incorrect timeout in mtd AMD driver of 2.4 kernel

Herbert Xu (1):
      SCTP: Always linearise packet on input

Jeff Garzik (1):
      ISDN: fix drivers, by handling errors thrown by ->readstat()

Martin Schwidefsky (3):
      copy_from_user information leak on s390.
      s390 : fix typo in recent copy_from_user fix
      [S390] user readable uninitialised kernel memory (3rd version)

Patrick McHardy (1):
      [NETFILTER]: Fix deadlock on NAT helper unload

Stephen Hemminger (1):
      [BRIDGE]: netfilter deadlock

Willy Tarreau (3):
      i386: remove unsigned long long cast in __pte() macro.
      2.4.x: i386/x86_64 bitops clobberings
      Change VERSION to 2.4.34-pre5

