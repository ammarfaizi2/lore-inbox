Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129856AbRBFTyR>; Tue, 6 Feb 2001 14:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129909AbRBFTyH>; Tue, 6 Feb 2001 14:54:07 -0500
Received: from jalon.able.es ([212.97.163.2]:17055 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129856AbRBFTyE>;
	Tue, 6 Feb 2001 14:54:04 -0500
Date: Tue, 6 Feb 2001 20:53:56 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: new gcc updates
Message-ID: <20010206205356.E4892@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have just installed the new gcc version in Mandrake (2.96-0.34). The
interesting point (related to kernel) is (rpm --chagelog):

- Big Red Hat merge, bring updated cpp BTW.
- (Red Hat patches, Jakub Jelinek (rel72) 7 new patches, 1 new tarball
..
  - optimize out comparisons of two constants if at least one comes from
    inline function arguments (visible e.g. on undefined __bad_udelay
    symbols from some linux 2.4.0 kernel modules)
  - put in updated preprocessor, it seems stable enough and has tons of bugs
    against both gcc 2.95.2 cccp and cpp used in 2.96-RH until now

and more fixes related to assembly output, which importance I don't fully
realize.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac3 #1 SMP Tue Feb 6 01:06:05 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
