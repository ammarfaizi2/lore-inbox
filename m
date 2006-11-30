Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936247AbWK3MGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936247AbWK3MGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936246AbWK3MGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:06:18 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:43277 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936247AbWK3MGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:06:18 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] mips: klconfig add missing bracket
Date: Thu, 30 Nov 2006 13:05:48 +0100
User-Agent: KMail/1.9.5
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <200611301016.29505.m.kozlowski@tuxland.pl> <20061130115944.GA9564@linux-mips.org>
In-Reply-To: <20061130115944.GA9564@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301305.49442.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch is ok but please add a Signed-off-by: line to every patch you
> send, See Documentation/SubmittingPatches for what this is about.

Right. Must have ovelooked that. Second try:

	This patch adds missing bracket.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/asm-mips/sn/klconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/include/asm-mips/sn/klconfig.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/asm-mips/sn/klconfig.h	2006-11-30 00:58:32.000000000 +0100
@@ -176,7 +176,7 @@ typedef struct kl_config_hdr {
 /* --- New Macros for the changed kl_config_hdr_t structure --- */
 
 #define PTR_CH_MALLOC_HDR(_k)   ((klc_malloc_hdr_t *)\
-			(unsigned long)_k + (_k->ch_malloc_hdr_off)))
+			((unsigned long)_k + (_k->ch_malloc_hdr_off)))
 
 #define KL_CONFIG_CH_MALLOC_HDR(_n)   PTR_CH_MALLOC_HDR(KL_CONFIG_HDR(_n))
 


-- 
Regards,

	Mariusz Kozlowski
