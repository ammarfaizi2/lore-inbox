Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWJQV1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWJQV1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbWJQV1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:27:07 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:33624 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750710AbWJQV1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=V2/zIeu4ROfd6DRnHppZlp0QTJW88+fzZ9ErDMdrPOJLV4Qfmk/ZFpK11szm8t4oJzkxdzeBam4NjWoUNVGhV2Ehw/kAFo7RXj8y+eLkt1qxgRJ+JL3wwvdv0LHsYtkudZ3vFI/Ul2DJXXKFdo6vcXZu8m+XcVs6Kn6S9e2jQuA=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 01/10] uml: remove some leftover PPC code
Date: Tue, 17 Oct 2006 23:27:05 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212705.26445.11192.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I happened to notice that this code is a leftover and it should be removed -
since there are sporadical efforts to revive the PPC port doing such cleanups
is not useless.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-um/archparam-ppc.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/include/asm-um/archparam-ppc.h b/include/asm-um/archparam-ppc.h
index 172cd6f..4269d8a 100644
--- a/include/asm-um/archparam-ppc.h
+++ b/include/asm-um/archparam-ppc.h
@@ -1,15 +1,6 @@
 #ifndef __UM_ARCHPARAM_PPC_H
 #define __UM_ARCHPARAM_PPC_H
 
-/********* Bits for asm-um/hw_irq.h **********/
-
-struct hw_interrupt_type;
-
-/********* Bits for asm-um/hardirq.h **********/
-
-#define irq_enter(cpu, irq) hardirq_enter(cpu)
-#define irq_exit(cpu, irq) hardirq_exit(cpu)
-
 /********* Bits for asm-um/string.h **********/
 
 #define __HAVE_ARCH_STRRCHR
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
