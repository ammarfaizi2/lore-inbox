Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132596AbRDBAsJ>; Sun, 1 Apr 2001 20:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132593AbRDBAsA>; Sun, 1 Apr 2001 20:48:00 -0400
Received: from hyperion.expio.net.nz ([202.27.199.10]:36614 "EHLO expio.co.nz")
	by vger.kernel.org with ESMTP id <S132594AbRDBAr5>;
	Sun, 1 Apr 2001 20:47:57 -0400
Message-ID: <014401c0bb0e$a38c6fc0$1400a8c0@expio.net.nz>
From: "Simon Garner" <sgarner@expio.co.nz>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1010401185932.6155D-100000@mandrakesoft.mandrakesoft.com>
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot 
Date: Mon, 2 Apr 2001 12:48:08 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff Garzik" <jgarzik@mandrakesoft.com>

> (private reply, because I have lost discussion context)
>
> Have you tried booting with 'noapic'?
>
>


Thanks Jeff, this seems to fix the problem, and also fixes my problem with
the aic7xxx scsi driver ABORTing multiple times at startup (which I presumed
was unrelated).

However, the machine now crashes at "Configuring Kernel Parameters" during
rc initialisation:


        Welcome to Red Hat Linux
    Press 'I' for interactive startup

Mounting /proc filesystem...        [   OK   ]
Configuring Kernel Parameters...


This is if I type "linux noapic" at the Lilo boot prompt.

Also, what do I lose by running with noapic?


Thanks

Simon Garner

