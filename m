Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135767AbREAM6j>; Tue, 1 May 2001 08:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135339AbREAM63>; Tue, 1 May 2001 08:58:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41992 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135767AbREAM6O>; Tue, 1 May 2001 08:58:14 -0400
Subject: Re: Followup to previous post: Atlon/VIA Instabilities
To: bergsoft@home.com (Seth Goldberg)
Date: Tue, 1 May 2001 14:02:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AEE9EA0.3752F0C0@home.com> from "Seth Goldberg" at May 01, 2001 04:31:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uZnD-0001bh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   So it seems that CONFIG_X86_USE_3DNOW is simply used to
> enable access to the routines in mmx.c (the athlon-optimized
> routines on CONFIG_K7 kernels), so then it appears that somehow
> this is corrupting memory / not behaving as it should (very
> technical, right?) :)...

Feel free to go over those routines in detail by hand. I've been over them and
I can't see any problems. The obvious candidates would be races in the
kernel_fpu_begin/end code but that also seems watertight to me.

