Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286950AbRL1Rfu>; Fri, 28 Dec 2001 12:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286952AbRL1Rfm>; Fri, 28 Dec 2001 12:35:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14602 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286950AbRL1Rf2>; Fri, 28 Dec 2001 12:35:28 -0500
Subject: Re: 2.4.17 absurd number of context switches
To: davidel@xmailserver.org (Davide Libenzi)
Date: Fri, 28 Dec 2001 17:45:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jwb@saturn5.com (Jeffrey W. Baker),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.40.0112280931271.1466-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Dec 28, 2001 09:33:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K14R-0001Bv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the scheduler will spend 3 entire time slices switching between B and C
> before A will get back the CPU and will free the lock.

Ugggh. That sounds horribly plausible. 
