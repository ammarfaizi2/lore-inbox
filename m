Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVEXRHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVEXRHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVEXRG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:06:29 -0400
Received: from pyxis.pixelized.ch ([213.239.200.113]:34308 "EHLO
	pyxis.pixelized.ch") by vger.kernel.org with ESMTP id S261292AbVEXRDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:03:22 -0400
Message-ID: <42935D89.90603@debian.org>
Date: Tue, 24 May 2005 18:59:53 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Compiler error in last git kernel [drivers/char/ipmi/ipmi_devintf.c]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   CC [M]  drivers/char/ipmi/ipmi_devintf.o
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
drivers/char/ipmi/ipmi_devintf.c:532: warning: passing arg 1 of `class_simple_device_add' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_smi_gone':
drivers/char/ipmi/ipmi_devintf.c:537: warning: passing arg 1 of `class_simple_device_remove' makes integer from pointer without a cast
drivers/char/ipmi/ipmi_devintf.c:537: error: too many arguments to function `class_simple_device_remove'
drivers/char/ipmi/ipmi_devintf.c: In function `init_ipmi_devintf':
drivers/char/ipmi/ipmi_devintf.c:558: warning: assignment from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:566: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c:580: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
drivers/char/ipmi/ipmi_devintf.c: In function `cleanup_ipmi':
drivers/char/ipmi/ipmi_devintf.c:591: warning: passing arg 1 of `class_simple_destroy' from incompatible pointer type
make[3]: *** [drivers/char/ipmi/ipmi_devintf.o] Error 1

ciao
	cate
