Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267108AbSK2Qfb>; Fri, 29 Nov 2002 11:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbSK2Qfa>; Fri, 29 Nov 2002 11:35:30 -0500
Received: from cibs9.sns.it ([192.167.206.29]:38404 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S267108AbSK2Qfa>;
	Fri, 29 Nov 2002 11:35:30 -0500
Date: Fri, 29 Nov 2002 17:42:52 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: Re: mou401.h fix for kernel 2.5.50
In-Reply-To: <Pine.LNX.4.43.0211291303210.1338-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.4.43.0211291741500.2547-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since pine broke new lines, I am reposting this.



 --- linux-2.5.50/sound/oss/mpu401.h.orig        2002-11-29 13:02:01.000000000 +0100
 +++ linux-2.5.50/sound/oss/mpu401.h     2002-11-29 13:01:28.000000000 +0100
 @@ -7,7 +7,7 @@

  /*     From mpu401.c */
  int probe_mpu401(struct address_info *hw_config);
 -void attach_mpu401(struct address_info * hw_config, struct module *owner);
 +int attach_mpu401(struct address_info *hw_config, struct module *owner);
  void unload_mpu401(struct address_info *hw_info);

  int intchk_mpu401(void *dev_id);

