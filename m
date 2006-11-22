Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757046AbWKVViW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046AbWKVViW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757047AbWKVViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:38:22 -0500
Received: from smtp8.orange.fr ([193.252.22.23]:14519 "EHLO
	smtp-msa-out08.orange.fr") by vger.kernel.org with ESMTP
	id S1757045AbWKVViV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:38:21 -0500
X-ME-UUID: 20061122213819519.013CC1C0026E@mwinf0802.orange.fr
Message-ID: <4564C34C.7050000@free.fr>
Date: Wed, 22 Nov 2006 22:38:20 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FYI build failure : 2.6.19-rc6-git5 unresolved spin_lock_irqsave_nested
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/built-in.o: dans la fonction « irlmp_slsap_inuse »:
irlmp.c:(.text+0x6ea89): référence indéfinie vers «
spin_lock_irqsave_nested »
make[1]: *** [.tmp_vmlinux1] Erreur 1
make: *** [bzImage] Erreur 2

-- eric
