Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271103AbTGPURH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271098AbTGPURD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:17:03 -0400
Received: from mailb.telia.com ([194.22.194.6]:44231 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S271095AbTGPURA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:17:00 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: [2.6.0-test1-mm1] Compile varnings
From: Christian Axelsson <smiler@lanil.mine.nu>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain
Message-Id: <1058387502.13489.2.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 22:31:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an i2c related warning:

CC      drivers/i2c/i2c-dev.o
drivers/i2c/i2c-dev.c: In function `show_dev':
drivers/i2c/i2c-dev.c:121: warning: unsigned int format, different type
arg (arg 3)

Note that this one is still here:

  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
0x37ffffff

-- 
Christian Axelsson
smiler@lanil.mine.nu

