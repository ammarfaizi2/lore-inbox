Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276470AbRJHQir>; Mon, 8 Oct 2001 12:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276987AbRJHQih>; Mon, 8 Oct 2001 12:38:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49422 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276470AbRJHQiZ>; Mon, 8 Oct 2001 12:38:25 -0400
Subject: Re: Desperately missing a working "pselect()" or similar...
To: lkv@isg.de
Date: Mon, 8 Oct 2001 17:44:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org (Kernel Linux)
In-Reply-To: <3BC1D506.E68B9DB2@isg.de> from "lkv@isg.de" at Oct 08, 2001 06:32:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qdVw-00016L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm... would you say the "siglongjmp" method is better than the "self-pipe"
> method for a select on both file descriptors and signals too?

siglongjmp doesnt have to make any syscalls so intuitively I'd say it
ought to be more efficient

> Then somebody mentioned using signals to wake up processes
> for frequent events wouldn't be a good idea at all - why?

Beats me

Alan

