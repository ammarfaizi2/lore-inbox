Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVHVTtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVHVTtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVHVTtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:49:40 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:6105 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750731AbVHVTtj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:49:39 -0400
X-Authenticated: #1172751
From: Rainer Koenig <Rainer.Koenig@gmx.de>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA status report updated
References: <4DbcF-8ux-3@gated-at.bofh.it> <4DbcG-8ux-5@gated-at.bofh.it>
	<4DbcF-8ux-1@gated-at.bofh.it> <4DjWG-4ea-19@gated-at.bofh.it>
	<4Do9X-1IZ-5@gated-at.bofh.it> <4Dp62-304-15@gated-at.bofh.it>
	<87r7co4o3m.fsf@Rainer.Koenig.Abg.dialin.t-online.de>
	<430987B1.80207@ti-wmc.nl>
Date: Mon, 22 Aug 2005 20:07:52 +0200
In-Reply-To: <430987B1.80207@ti-wmc.nl> (Simon Oosthoek's message of "Mon,
 22 Aug 2005 10:07:13 +0200")
Message-ID: <87fyt1u9on.fsf@Rainer.Koenig.Abg.dialin.t-online.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Simon Oosthoek <simon.oosthoek@ti-wmc.nl> writes:

> Unfortunately I'm not able to check the logic of the driver, because
> although I can read C, I'm totally unfamiliar with the disk controler
> logic in the kernel...

Well, today I've spent some time in looking at the SiS driver and compared
it with the driver that is in kernel 2.6.10. And keeping Jeff's comments
about libata in mind (together with a printout of libata.h) helped a bit 
to understand the differences. So I will see if I can somehow get the
important things from the SiS driver while using whatever libata 
provides already. Will take some time anyway since kernel hacking is
not the main focus of my job. Anyway, I will try. I guess the main 
issue is to find the 0x182 specific details and merge them into the
kernel driver. 

Best regards
Rainer
-- 
Rainer König, Diplom-Informatiker (FH), Augsburg, Germany
