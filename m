Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWJEVpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWJEVpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWJEVpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:45:10 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:7871 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932262AbWJEVmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:42:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=icFgjvVa3wteXC7nCZOztdXL//yvEgNqqExRfxST4RBGdjGZbLglxs8ERcz8D9OAYPdDix+QFK5wtY+B8I94hjkU6vsBlnha+GjdkNRFXpsJGdCyg7o4owIM41CdGd+uNtRe7PYegUinGcA2Z6hOAmyMKwYWOU/emazDAou4PDs=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 12/14] uml: remove duplicate export
Date: Thu, 05 Oct 2006 23:39:13 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213913.17268.66477.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The export is together with the definition, in arch/x86_64/lib/csum-partial.c,
which is compiled in by arch/um/sys-x86_64/Makefile.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-x86_64/ksyms.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/um/sys-x86_64/ksyms.c b/arch/um/sys-x86_64/ksyms.c
index 8592738..12c5936 100644
--- a/arch/um/sys-x86_64/ksyms.c
+++ b/arch/um/sys-x86_64/ksyms.c
@@ -14,6 +14,3 @@ EXPORT_SYMBOL(__up_wakeup);
 
 /*XXX: we need them because they would be exported by x86_64 */
 EXPORT_SYMBOL(__memcpy);
-
-/* Networking helper routines. */
-EXPORT_SYMBOL(ip_compute_csum);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
