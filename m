Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTI2NrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTI2NrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:47:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:24761 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263386AbTI2NrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:47:07 -0400
X-Authenticated: #13243522
Message-ID: <3F783793.5B7E4FB3@gmx.de>
Date: Mon, 29 Sep 2003 15:45:55 +0200
From: Michael Schierl <schierlm@gmx.de>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD QXW0324v  (Win95; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test4,5,6] [APM] when do you expect to get APM workingagain?
References: <S263203AbTI2MAQ/20030929120016Z+1564@vger.kernel.org> <1064841037.3970.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana schrieb:

> It's working fine for me, but I still need to unload some modules before
> trying to suspend. In my case, I must remove the CardBus/PCMCIA modules,
> the sound drivers and UHCI-HCD for my system to suspend and then resume
> properly.

i cannot unload those as I don't have any module support in my kernel 
(and no current module-init-tools installed either) - one thing less 
that one can do go wrong.

but i can try to remove support for them from the kernel to track 
down the issue.

Michael
