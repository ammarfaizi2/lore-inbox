Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbRLXViG>; Mon, 24 Dec 2001 16:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285360AbRLXVh4>; Mon, 24 Dec 2001 16:37:56 -0500
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:22656 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S285352AbRLXVho>;
	Mon, 24 Dec 2001 16:37:44 -0500
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200112242137.fBOLbcU08347@meduna.org>
Subject: Re: IDE CDROM locks the system hard on media error
To: andre@linux-ide.org (Andre Hedrick)
Date: Mon, 24 Dec 2001 22:37:38 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112241231000.14431-100000@master.linux-ide.org> from "Andre Hedrick" at dec 24, 2001 12:58:26
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> If it is DMAing and there is a 1us transaction delay it is toast.

Oh... But why does the whole kernel lock up?

> Intel PIIX4 AB/EB is a NO-NO for doing ATAPI on.

Only when using DMA or generally?

Maybe there should be some "quirk" disallowing this or at least
warn when the user happens to select this?

Regards
-- 
                                      Stano

