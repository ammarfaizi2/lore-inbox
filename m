Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265452AbRGLPEV>; Thu, 12 Jul 2001 11:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265467AbRGLPEL>; Thu, 12 Jul 2001 11:04:11 -0400
Received: from motgate2.mot.com ([136.182.1.10]:63686 "EHLO motgate2.mot.com")
	by vger.kernel.org with ESMTP id <S265452AbRGLPD4>;
	Thu, 12 Jul 2001 11:03:56 -0400
Message-Id: <3B4DBB46.24EB460F@crm.mot.com>
Date: Thu, 12 Jul 2001 16:59:18 +0200
From: Emmanuel Varagnat <varagnat@crm.mot.com>
Organization: Motorola
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Makefile problem and modules
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote a module for IPv6 but there is a case when it is
compiled.
(For the moment my code can only work as a module...)
When IPv6 is compiled as a module, my module is well compiled.
But if IPv6 is directly in the kernel, my module is not take
into account (I've got no object file).

Here is the only line I added to the Makefile (near the end):

obj-$(CONFIG_IPV6_MYSTUFF)  += mystuff.o

Thanks in advance.

-Manu
