Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbQKJPoM>; Fri, 10 Nov 2000 10:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131299AbQKJPoC>; Fri, 10 Nov 2000 10:44:02 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:33781
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131038AbQKJPnv>; Fri, 10 Nov 2000 10:43:51 -0500
Date: Fri, 10 Nov 2000 08:42:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001110084211.B24101@opus.bloom.county>
In-Reply-To: <200011100344.TAA01282@pizda.ninka.net> <19341005050711.11931@192.168.1.2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <19341005050711.11931@192.168.1.2>; from bh40@calva.net on Fri, Nov 10, 2000 at 12:35:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 12:35:27PM +0100, Benjamin Herrenschmidt wrote:
> >   o	Resnchronize Apple PowerMac codebase		(Paul Mackerras & co)
> >
> >BUUUG, new DEV_MAC_HID sysctl number conflicts with DEV_MD
> >in Ingo's raid patches.
> 
> Well, I beleive DEV_MAC_HID can safely be changed to something else as
> userland only use the /proc entry name./

One question here.  Is it important here that the # be consistant?  I mean
since to change a sysctl isn't the name the important bit? ie:
dev.md.speed_limit would work regardless of if DEV_MD is 3 or 4?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
