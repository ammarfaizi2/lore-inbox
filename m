Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVD0Hd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVD0Hd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVD0Hd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:33:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:3478 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261749AbVD0Hdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 03:33:55 -0400
Date: Wed, 27 Apr 2005 00:33:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] Toshiba driver cleanup
Message-Id: <20050427003329.02dab427.akpm@osdl.org>
In-Reply-To: <200504270150.06196.dtor_core@ameritech.net>
References: <200504270149.13450.dtor_core@ameritech.net>
	<200504270150.06196.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> Toshiba legacy driver cleanup:


--- 25/drivers/char/toshiba.c~toshiba-driver-cleanup-fix	2005-04-27 00:32:47.306512192 -0700
+++ 25-akpm/drivers/char/toshiba.c	2005-04-27 00:32:51.521871360 -0700
@@ -79,7 +79,7 @@ MODULE_DESCRIPTION("Toshiba laptop SMM d
 MODULE_SUPPORTED_DEVICE("toshiba");
 
 static int tosh_fn;
-module_param(fn, int, 0);
+module_param(tosh_fn, int, 0);
 MODULE_PARM_DESC(tosh_fn, "User specified Fn key detection port");
 
 static int tosh_id;
_

