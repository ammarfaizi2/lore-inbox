Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130879AbQKUTEA>; Tue, 21 Nov 2000 14:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130875AbQKUTDv>; Tue, 21 Nov 2000 14:03:51 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:50699
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130701AbQKUTDc>; Tue, 21 Nov 2000 14:03:32 -0500
Date: Tue, 21 Nov 2000 10:32:09 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Peter Samuelson <peter@cadcamlab.org>
cc: David Woodhouse <dwmw2@infradead.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem
In-Reply-To: <20001121061511.F2918@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.10.10011211030300.26689-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Peter Samuelson wrote:

> The way I understood Hakan was: "it boots in udma4, and if it gets all
> the way to userland I immediately hdparm it down to udma3, and then it
> works fine".

No, if it doesn not hang and we get iCRC errors it will down grade
automatically, but it is a transfer rate issue than it must be hard coded
to force an upper threshold limit.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
