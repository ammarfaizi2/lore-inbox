Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269242AbUHaXq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbUHaXq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269128AbUHaXqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:46:30 -0400
Received: from smtp06.auna.com ([62.81.186.16]:36346 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S269242AbUHaX3j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:29:39 -0400
Date: Tue, 31 Aug 2004 23:29:35 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: 2.6.8.1-mm3 and above hang with iptables and sound
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
X-Mailer: Balsa 2.2.4
Message-Id: <1093994975l.7733l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have many problems with kernels from 2.6.8.1-mm3 and above (-mm4,
2.6.9-rc1,-mm1).
When initscripts reach the load of stored iptables rules, the box hangs.
If I disable iptables, it hangs on loading the sound module (snd_intel8x0
in my case).

I think the only common thing is that both do some load and _removal_ of
modules to check things.

Previuos kernels work fine (apart from the need to boot with pci=routeirq).

Any idea on what changed in 2.6.8.1-mm3 ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Beta 1) for i586
Linux 2.6.8.1-mm2 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #3


