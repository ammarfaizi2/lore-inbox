Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966353AbWKNVM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966353AbWKNVM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966359AbWKNVM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:12:57 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:21401 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S966353AbWKNVM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:12:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GVyhYt1a5jpo886VuKYT8gDqb/MGzIhS2e4XQ0dDAGSvZXUd+pYHqQCWM1OMgapTxH7j+7Qe2hFZVLTImJxR7MsE0+MOtqPpwQ6uN1wdnYz/oCzKMf3yERARQ9Wy/Xo9hv2T+9jxzRvCN6y4eAr/8xIJ8+pFBfK6q9B9310rodo=
Date: Wed, 15 Nov 2006 06:12:59 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Don Mullis <dwm@meer.net>
Subject: [PATCH -mm] CONFIG_FAULT_INJECTION help text
Message-ID: <20061114211259.GA20524@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Don Mullis <dwm@meer.net>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114200249.GM22565@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114200249.GM22565@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 09:02:49PM +0100, Adrian Bunk wrote:
> The FAULT_INJECTION option lacks a help text.

Thank you for pointing that out.

Subject: [PATCH -mm] CONFIG_FAULT_INJECTION help text

This patch add a help text for CONFIG_FAULT_INJECTION

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 lib/Kconfig.debug |    3 +++
 1 file changed, 3 insertions(+)

Index: work-fault-inject/lib/Kconfig.debug
===================================================================
--- work-fault-inject.orig/lib/Kconfig.debug
+++ work-fault-inject/lib/Kconfig.debug
@@ -477,6 +477,9 @@ config FAULT_INJECTION
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE
 	select FRAME_POINTER
+	help
+	  Provide fault-injection framework.
+	  For more details, see Documentation/fault-injection/.
 
 config FAILSLAB
 	bool "Fault-injection capability for kmalloc"
