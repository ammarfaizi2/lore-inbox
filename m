Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVGKHbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVGKHbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 03:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVGKHbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 03:31:40 -0400
Received: from acheron.ifi.lmu.de ([129.187.214.135]:60311 "EHLO
	acheron.ifi.lmu.de") by vger.kernel.org with ESMTP id S261198AbVGKHbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 03:31:39 -0400
Message-ID: <42D22059.8000607@bio.ifi.lmu.de>
Date: Mon, 11 Jul 2005 09:31:37 +0200
From: Frank Steiner <fsteiner-mail1@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: tg3 fails with x86_64 (but works with i386)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've two 3com 3C996B-T network cards (lspci says it's
a Broadcom BCM5701 chip) in Asus A8V boards with an
AMD64 4000+ cpu. Booting a x86_64 version of the
2.6.12.2 kernel, the tg3 module complains

   tg3.c: v3.31 (June 8, 2005)
   tg3_test_dma() Write the buffer failed -19
   tg3: DMA engine test failed, aborting.

and no eth0 is available. However, when booting a 32bit
version of 2.6.12.2, the cards work well with the tg3
module. So it must be some problem in the x86_64
specific kernel code.

Any ideas what I could do? What further information can
I provide?

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
