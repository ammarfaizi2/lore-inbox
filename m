Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130811AbRBQBav>; Fri, 16 Feb 2001 20:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbRBQBac>; Fri, 16 Feb 2001 20:30:32 -0500
Received: from jalon.able.es ([212.97.163.2]:22211 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131385AbRBQBaV>;
	Fri, 16 Feb 2001 20:30:21 -0500
Date: Sat, 17 Feb 2001 02:30:14 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: gcc-2.96 and kernel
Message-ID: <20010217023014.C968@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(I suppose people track this info, but a remark never hurts...)

Just updated Mandrake gcc to gcc-2.96-0.37mdk. Interesting point:
* Thu Feb 15 2001 David BAUDENS <baudens@mandrakesoft.com> 2.96-0.37mdk

- Fix build on PPC :)

* Thu Feb 15 2001 Chmouel Boudjnah <chmouel@mandrakesoft.com> 2.96-0.36mdk

- Break build on PPC ;).
- Red Hat patches, Jakub Jelinek (rel74) 5 new patches :
  - fix last cpp patch so that no whitespace is inserted at start of line
    if last macro expansion resulted in no tokens (Neil Booth)
  - fix ICE during printing warning about overloading decisions (#23584)
  - honor no implicit extern "C" on linux in cpp
  - fix layout of __attribute((packed)) enums in bitfields (showing up
    in Linux DAC960 driver)
    ^^^^^^^^^^^^^^^^^^^^^^^
..

The last thing remaining to recommend 2.96 ? Who knows...

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac14 #1 SMP Thu Feb 15 16:05:52 CET 2001 i686

