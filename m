Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTIVOm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263175AbTIVOm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:42:57 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:53669 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263173AbTIVOm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:42:56 -0400
Message-Id: <200309221442.h8MEfGkT005657@ginger.cmf.nrl.navy.mil>
To: Felipe W Damasio <felipewd@terra.com.br>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Using possibly corrupted structure in atm/he.c 
In-Reply-To: Message from Felipe W Damasio <felipewd@terra.com.br> 
   of "Sun, 21 Sep 2003 01:25:22 -0300." <3F6D2832.8040609@terra.com.br> 
Date: Mon, 22 Sep 2003 10:41:18 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-6.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F6D2832.8040609@terra.com.br>,Felipe W Damasio writes:
>	If copy_from_user returns != 0, it means the the regs structure wasn't 
>filled correctly, and since its fields are used to determine which ioctl 
>the user is requesting the kernel could oops.
>
>	And as long as we're covering the subject, the patch also audits 
>copy_to_user on the same function to check a possible failure to copy 
>the result back to userspace.

indeed these are broken as written.  i will get this sent up the chain.
