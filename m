Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293113AbSBWItW>; Sat, 23 Feb 2002 03:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293115AbSBWItK>; Sat, 23 Feb 2002 03:49:10 -0500
Received: from zeus.kernel.org ([204.152.189.113]:926 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S293113AbSBWIst>;
	Sat, 23 Feb 2002 03:48:49 -0500
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
To: jamagallon@able.es (J.A. Magallon)
Date: Sat, 23 Feb 2002 00:23:01 -0800 (PST)
Cc: barryn@pobox.com (Barry K. Nathan),
        linux-kernel@vger.kernel.org (Lista Linux-Kernel),
        rwhron@earthlink.net
In-Reply-To: <20020223023332.A1689@werewolf.able.es> from "J.A. Magallon" at Feb 23, 2002 02:33:32 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020223082301.34EDF89C87@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> My box also hangs acessing the floppy. Strange thing is that it also
> hangs without irqrate-A1. Will send an oops.

It could be one of the patches that comes before irqrate-A1 in the 00-90
numbering sequence that your patches use; I've definitely reproduced this
without any of the patches numbered higher than the irqrate-A1 patch.(In
my case, if I applied all of those patches except the irqrate one, I
didn't get the freeze. If I applied all the patches up to the irqrate one
after, then I got the freeze.)

-Barry K. Nathan <barryn@pobox.com>
