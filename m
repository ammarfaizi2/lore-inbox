Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276343AbRI1WPm>; Fri, 28 Sep 2001 18:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276346AbRI1WPc>; Fri, 28 Sep 2001 18:15:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56331 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276343AbRI1WP3>; Fri, 28 Sep 2001 18:15:29 -0400
Subject: Re: 2.4.9-ac16 good perfomer?
To: linux4u@wanadoo.es (Pau Aliagas)
Date: Fri, 28 Sep 2001 23:20:08 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel), davidsen@tmr.com (bill davidsen),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109282109590.10387-100000@pau.intranet.ct> from "Pau Aliagas" at Sep 28, 2001 09:14:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n5zM-00006b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> idle for some time, for instance after the screensaver has been running
> during lunch time; it takes a few seconds moving from desktop to desktop
> til it "swaps in" applications again. Maybe we are throwing away pages too
> aggressively?

-ac is throwing away dcache too aggressively currently, that needs
addressing in part by pruning the dcache and inode cache more smartly

Alan
