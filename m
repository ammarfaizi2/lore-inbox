Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVGYOgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVGYOgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVGYOeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:34:03 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:15914 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261237AbVGYOcC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:32:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DrqA7aizzCZACa4f5LwORfYIdFAIdDEVCCxWBhZkp9BiCOr8oS2CKIRSSGOM9oP23tt6j76I+DnXvt2sRKqtyFoeGtBt23B+OVTagDuwBthKToImkOUx/Q9mpMniaxM0t9acx4z041JDJGlxl0CazuqsnJunW5n/1fXTBuqK+3A=
Message-ID: <105c793f05072507315cfd1878@mail.gmail.com>
Date: Mon, 25 Jul 2005 10:31:37 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUG: Yamaha OPL3SA2 does not work with ALSA on 2.6 kernels.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have a 5 year old Gateway Solo 2500 that is currently running Linux
2.6.12.2. If I install ALSA and try to have alsaconf bruteforce-detect
the OPL3SA2 sound card, it will say that it has detected it, but
loading the modules will fail. If I install Linux 2.4 and
recompile/rerun alsaconf, the detection works fine and the card works.
Copying the configuration detected under 2.4 into a modprobe.conf on
2.6 allows me to use the card in 2.6 with occasional crashes (which
might be due to suspend2).

Searching around the net, I find many other people having trouble with
these cards and the ALSA-Linux2.6 combination. On one page, someone
suggested that there were changes made between 2.4 and 2.6 to the ISA
code that broke ALSA's detection routines.

I'm not sure what information might be needed in order to get this
card working well once and for all, but if someone will let me know,
I'd be happy to provide.

Thanks.

-Andy
