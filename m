Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQKFVdj>; Mon, 6 Nov 2000 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbQKFVd3>; Mon, 6 Nov 2000 16:33:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29280 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129392AbQKFVdP>; Mon, 6 Nov 2000 16:33:15 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: Tim@Rikers.org (Tim Riker)
Date: Mon, 6 Nov 2000 21:33:18 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), linux-kernel@vger.kernel.org
In-Reply-To: <3A07063C.612A225@Rikers.org> from "Tim Riker" at Nov 06, 2000 12:27:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sttH-0006ej-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Barring this, we could create a persistantdata module that we can
> modprobe and then discover with Keith's inter_module_xxx and read/write
> opaque data to/from. Then if the user does not want to use it they can
> just "alias persistantdata off" it and poof.

All of this is kernel code we don't need.  Its not a good solution generically
or otherwise. Modutils should just use the persistent data stuff that has hooks
ready to roll already.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
