Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQLWQYK>; Sat, 23 Dec 2000 11:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130300AbQLWQYA>; Sat, 23 Dec 2000 11:24:00 -0500
Received: from winds.org ([209.115.81.9]:13830 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129535AbQLWQXp>;
	Sat, 23 Dec 2000 11:23:45 -0500
Date: Sat, 23 Dec 2000 10:53:11 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Rok Pergarec <mammbo@knux.nu>
cc: linux-kernel@vger.kernel.org
Subject: Re: ATI Mach 64 (2.4.0-test12)
In-Reply-To: <Pine.LNX.4.20.0012230940310.1633-100000@ns.knux.nu>
Message-ID: <Pine.LNX.4.21.0012231048530.2110-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, Rok Pergarec wrote:

> Hello,
> 
> I have problems with the ATI Mach 64 (Rage 2) video card. After a boot, I
> get just a blank screen with a few vertical lines, but the system boots up
> normally beacuse I can reboot the machine anyway. I don't get a sigle
> error in compiling.

Try configuring just standard 'VGA text console' and disabling 'Video mode
selection support'. Don't configure any special ATI choices either (or frame
buffering), and see if it boots up then. The Mach64 should have standard VGA
capabilities and should be compatible with every other vga card on bootup.

If it still doesn't work, send me your /usr/src/linux/.config file so I can see
what you have configured.

Regards,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
