Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291090AbSBMAP0>; Tue, 12 Feb 2002 19:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291077AbSBMAPR>; Tue, 12 Feb 2002 19:15:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13331 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291090AbSBMAPH>; Tue, 12 Feb 2002 19:15:07 -0500
Subject: Re: [patch] sys_sync livelock fix
To: akpm@zip.com.au (Andrew Morton)
Date: Wed, 13 Feb 2002 00:28:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3C69A3C8.17160BC3@zip.com.au> from "Andrew Morton" at Feb 12, 2002 03:22:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16anHf-0003bt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Whats wrong with sync not terminating when there is permenantly I/O left ?
> > Its seems preferably to suprise data loss
> 
> Hard call.  What do we *want* sync to do?

I'd rather not change the 2.4 behaviour - just in case. For 2.5 I really
have no opinion either way if SuS doesn't mind
