Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130774AbQK1NPw>; Tue, 28 Nov 2000 08:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131106AbQK1NPm>; Tue, 28 Nov 2000 08:15:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25632 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S130774AbQK1NPe>; Tue, 28 Nov 2000 08:15:34 -0500
Subject: Re: 2.2.18pre19 oops in try_to_free_pages
To: vherva@mail.niksula.cs.hut.fi (Ville Herva)
Date: Tue, 28 Nov 2000 12:45:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001128134418.C54301@niksula.cs.hut.fi> from "Ville Herva" at Nov 28, 2000 01:44:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140k8t-0004Sv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW: What are those seemingly harmless "VFS: busy inodes on changed
> media." messages I'm getting tons of?

They are not harmless. Someone forcibly unmounted a disk of some sort
from a device that was in use, and while that shouldnt have killed the box
it seems it did

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
