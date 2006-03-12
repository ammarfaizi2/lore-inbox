Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWCLPzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWCLPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWCLPzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:55:08 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:48364 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751207AbWCLPzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:55:06 -0500
Date: Sun, 12 Mar 2006 16:55:15 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm1
Message-ID: <20060312155515.GD16013@ens-lyon.fr>
References: <20060312031036.3a382581.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> 
> 

drivers/net/tg3.c:8065: warning: type qualifiers ignored on function return type

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>

Index: linux/drivers/net/tg3.c
===================================================================
--- linux.orig/drivers/net/tg3.c
+++ linux/drivers/net/tg3.c
@@ -8061,7 +8061,7 @@ static int tg3_test_link(struct tg3 *tp)
 }
 
 /* Only test the commonly used registers */
-static const int tg3_test_registers(struct tg3 *tp)
+static int tg3_test_registers(struct tg3 *tp)
 {
 	int i, is_5705;
 	u32 offset, read_mask, write_mask, val, save_val, read_val;

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
