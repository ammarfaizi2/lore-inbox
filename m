Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318822AbSHANnq>; Thu, 1 Aug 2002 09:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSHANnq>; Thu, 1 Aug 2002 09:43:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26542 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318822AbSHANnp>;
	Thu, 1 Aug 2002 09:43:45 -0400
Date: Thu, 1 Aug 2002 15:45:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Marcin Dalecki <dalecki@evision.ag>
Subject: [bug, 2.5.29, IDE] partition table corruption?
Message-ID: <Pine.LNX.4.44.0208011541590.19906-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


using 2.5.29 (vanilla or BK-curr) i cannot use /sbin/lilo anymore to
update the partition table.

if i do it then the partition table gets corrupted and the system does not
boot - it stops at 'LI'. (iirc meaning that the second-stage loader does
not load?) Using a recovery CD fixes the problem, so it's only the
partition info that got trashed, not the filesystem.

i use IDE disks.

this makes development under 2.5.29 quite inconvenient - i have to boot
back into another kernel whenever loading a new kernel.

	Ingo


