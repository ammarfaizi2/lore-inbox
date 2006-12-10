Return-Path: <linux-kernel-owner+w=401wt.eu-S1759967AbWLJGsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759967AbWLJGsL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 01:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759243AbWLJGsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 01:48:11 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:2285 "EHLO
	jenny.ondioline.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759967AbWLJGsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 01:48:10 -0500
From: Paul Collins <paul@briny.ondioline.org>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: powerpc: "IRQ probe failed (0x0)" on powerbook
Mail-Followup-To: linuxppc-dev@ozlabs.org, paulus@samba.org,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Date: Sun, 10 Dec 2006 19:45:48 +1300
Message-ID: <87lklg9rkz.fsf@briny.internal.ondioline.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my PowerBook when booting Linus's tree as of commit af1713e0 I get
something like this:

  [blah blah]
  ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 0
  Probing IDE interface ide0...
  hda: HTS541080G9AT00, ATA DISK drive
  IRQ probe failed (0x0)
  IRQ probe failed (0x0)
  IRQ probe failed (0x0)
  IRQ probe failed (0x0)

And then of course it fails to mount root.  No such problem using a
kernel built from commit 97be852f of December 2nd.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
