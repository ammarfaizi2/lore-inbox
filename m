Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131370AbRA0KxK>; Sat, 27 Jan 2001 05:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbRA0Kwu>; Sat, 27 Jan 2001 05:52:50 -0500
Received: from [194.213.32.137] ([194.213.32.137]:31236 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131370AbRA0Kwk>;
	Sat, 27 Jan 2001 05:52:40 -0500
Message-ID: <20010126185150.D260@bug.ucw.cz>
Date: Fri, 26 Jan 2001 18:51:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: mirabilos <eccesys@topmail.de>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Hercules Graphics Card
In-Reply-To: <006001c0861a$0c85c960$0100a8c0@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <006001c0861a$0c85c960$0100a8c0@homeip.net>; from mirabilos on Wed, Jan 24, 2001 at 03:22:57PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> I'm too using this, mostly because I like it, got up with it, and it's better than those pixelled displays today. And who needs colours?
> For me, it says (2.4.0-prerelease) I'd got a HGC with 8 kB of RAM.
> This surely isn't true because under DOS some pgmz work problemless
> which use the whole 64K of &hB0000 to &hBFFFF (when I deactivate the VGA
> card), and even Turbo Debugger 1.0's dual-screen option works in both gfx and
> text mode, with the other card as debugging display in text mode, no matter whether the PGM uses HGC or VGA as primary display.
> I'm sorry I've got no correction, but prolly you could try to read-modify-write-read-write_original, and compare the read value with the written bzw. the original.
> And - do we get a HGC gfx framebuffer hgc1fb? (Btw, the vga16fb must
> be called vga4fb - it uses 4 bit colour, not 16)

Yes. I'm using it on my HGC to display graphics. It is called hgafb
(or so?) and included in 2.4.0.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
