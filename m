Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291280AbSBMA62>; Tue, 12 Feb 2002 19:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291282AbSBMA6S>; Tue, 12 Feb 2002 19:58:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291280AbSBMA6G>; Tue, 12 Feb 2002 19:58:06 -0500
Subject: Re: [patch] sys_sync livelock fix
To: riel@conectiva.com.br (Rik van Riel)
Date: Wed, 13 Feb 2002 00:25:54 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.33L.0202122128151.12554-100000@imladris.surriel.com> from "Rik van Riel" at Feb 12, 2002 09:29:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16anFC-0003bD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Its seems preferably to suprise data loss
> 
> The data isn't lost, it'll simply get written out to
> disk later.

Allow me to introduce you to the off button, and the scripts at shutdown
which use sync
