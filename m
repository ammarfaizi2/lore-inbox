Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUADSAk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 13:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265785AbUADSAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 13:00:40 -0500
Received: from shadow02.cubit.at ([80.78.231.91]:35487 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S265775AbUADSAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 13:00:31 -0500
Message-ID: <003701c3d2ec$a066c3b0$02bfa8c0@kuecken>
From: "Andreas Unterkircher" <unki@netshadow.at>
To: "Herve Fache" <herve.fache@europemail.com>, <linux-kernel@vger.kernel.org>
References: <20040104173624.19046.qmail@iname.com>
Subject: Re: Linux hangs on nVidia nForce2 400 Ultra
Date: Sun, 4 Jan 2004 19:00:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According your .config you have compiled all ide-chipsets.

Have you tried only compile in the
AMD74XX (CONFIG_BLK_DEV_AMD74XX=y) AMD and nVidia IDE support?

This is the only necessary IDE-Chipset on my Nforce Board.... Perhaps this
would help.
Can you supply a dmesg output?

Andreas

----- Original Message ----- 
From: "Herve Fache" <herve.fache@europemail.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, January 04, 2004 6:36 PM
Subject: Linux hangs on nVidia nForce2 400 Ultra


> Hi chaps!
>
> My system hangs (no oops, nothing) on disk access using either 2.4.23 or
2.6.0. A rather reliable way for me to
> crash it is to, for example, copy the sources of the Linux kernel.
>
> It hanged once on CD-ROM access, which could lead to a more IDE-level
problem. Also, the only time it did it in
> another operating system (humm...) was after it crashed in Linux and I
pressed reset (no shut down), which
> makes me think it could the IDE controller [driver]'s fault...
>
> It seems I'm the only one on Earth to have this problem (according to
Google), but if there was a way to track it
> down I'd be happy to try.
>
> I have attached my 2.6.0 kernel config for info.
>
> Thanks!
> Hervé.
> -- 
> ___________________________________________________________
> Sign-up for Ads Free at Mail.com
> http://promo.mail.com/adsfreejump.htm
>
>

