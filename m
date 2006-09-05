Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbWIEJbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbWIEJbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 05:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWIEJbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 05:31:16 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:11244 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S965182AbWIEJbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 05:31:15 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <44FEBC56-5DD1-42C8-B593-8E1430ECAA9C@fnux.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Alexis ROBERT <alexis@fnux.org>
Subject: intel_agp and EFI (Intel MacBook)
Date: Tue, 5 Sep 2006 11:31:12 +0200
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've a little problem with my new MacBook and Linux running EFI  
(without BIOS emulation) : when it loads the intel_agp module, the  
screen goes gray with colored stripes". I've tried to load the  
"agpgart" module alone, it works (this one is used by intel_agp).

Also, the framebuffer works perfectly (only using  
video=imacfb:macbook), and intel_agp works using BIOS emulation.

Thats what the kernel says (thanks to ssh :) ) :
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 16124K stolen memory.
agpgart: AGP aperture is 256M @ 0x80000000

I forgot ! I use 2.6.17.11 with mactel-linux patches (but it looks it  
doesn't patch intel_agp).

Thanks in advance

Alexis ROBERT
