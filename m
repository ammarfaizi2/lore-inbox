Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTE2UgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTE2UgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:36:05 -0400
Received: from smtp-out-01.utu.fi ([130.232.202.171]:49294 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S262656AbTE2UgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:36:05 -0400
Date: Thu, 29 May 2003 23:49:23 +0300
From: =?iso-8859-1?Q?Tero_J=E4nk=E4?= <tesaja@utu.fi>
Subject: CONFIG_PIIX_TUNING in 2.4.21-rc6
To: linux-kernel@vger.kernel.org
Message-id: <20030529204923.GB6441@tron.yok.utu.fi>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nitpicking follows.

Looks like CONFIG_PIIX_TUNING configuration option is partially removed from
the kernel. No references to it can be found in the code at least. However
there still remains references to CONFIG_PIIX_TUNING in Documentation/Configure.help
and arch/*/defconfig* files, which might confuse people unnecessarily. So if
CONFIG_PIIX_TUNING configuration option is not used anymore, I suggest the
trivial 'fix' of removing all references to it.

Particularly, at least these two lines should be removed from under
CONFIG_BLK_DEV_PIIX in Documentation/Configure.help:

  If you say Y here, you should also say Y to "PIIXn Tuning support",
  below.

-- 
Tero Jänkä
