Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275980AbRJILlt>; Tue, 9 Oct 2001 07:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276118AbRJILlj>; Tue, 9 Oct 2001 07:41:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63495 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275980AbRJILla>; Tue, 9 Oct 2001 07:41:30 -0400
Subject: Re: AIC7xxx panic
To: dmgrime@appliedtheory.com (David M. Grimes)
Date: Tue, 9 Oct 2001 12:47:15 +0100 (BST)
Cc: noth@noth.is.eleet.ca (Jim Crilly), linux-kernel@vger.kernel.org
In-Reply-To: <20011008205112.C34894@appliedtheory.com> from "David M. Grimes" at Oct 08, 2001 08:51:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qvLv-0003ra-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Were there recent changes in ll_rw_blk which are being addressed by
> "Elevator flow control"?  As suggested earlier in this thread, the cause
> might be a few layers up, and this seemed relevant.

Unrelated I suspect. All it means is that in some cases -ac will have less
segments queued before blocking. The max sectors per I/O and max segments
per I/o are controlled by the drivers
