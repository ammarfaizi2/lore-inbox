Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVDER0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVDER0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVDERYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:24:39 -0400
Received: from pop.gmx.net ([213.165.64.20]:55763 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261839AbVDERKe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:10:34 -0400
X-Authenticated: #222435
From: Jonas Diemer <diemer@gmx.de>
To: Vernon Mauery <vmauery@gmail.com>
Subject: Re: security issue: hard disk lock
Date: Tue, 5 Apr 2005 19:10:30 +0200
User-Agent: KMail/1.8
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
References: <200504041832.j34IW6PO030096@laptop11.inf.utfsm.cl> <4252B1A9.3040005@gmail.com>
In-Reply-To: <4252B1A9.3040005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504051910.30562.diemer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 05. April 2005 17:41 schrieb Vernon Mauery:
>  This makes sense because a particularly malicious
> place to put something like this is a worm that attaches to your boot
> loader.  Then, even doing it in the kernel at boot time is too late.

I understand... Didn't know that worms could attach to the bootloader :-) 
Well, then even fixing this in the bootloader would be too late, if the worm 
could simply replace the bootloader. I guess it's not a kernel-issue then and 
should really be addressed in the boot-up sequence (as long as BIOS vendors 
fail to fix it), be it with or without initrd.

regards,
Jonas

PS: Still not in list, so please CC me on eventual replies.
