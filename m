Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUFFIoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUFFIoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUFFIoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:44:30 -0400
Received: from imap.gmx.net ([213.165.64.20]:36748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263079AbUFFIo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:44:28 -0400
X-Authenticated: #4512188
Message-ID: <40C2D969.4010509@gmx.de>
Date: Sun, 06 Jun 2004 10:44:25 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040604)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Lane <miles.lane@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-bk6 -- mtrr: 0xd0000000,0x8000000 overlaps existing
 0xd0000000,0x200000
References: <40C28573.6070704@comcast.net>
In-Reply-To: <40C28573.6070704@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> I am getting an error using the nv open-source driver
> for the GeForce FX 5600 board.
> 
> vesafb: framebuffer at 0xd0000000, mapped to 0xf8808000, size 3072k
> vesafb: mode is 1024x768x16, linelength=2048, pages=1
> vesafb: protected mode interface info at c000:f530
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
> fb0: VESA VGA frame buffer device
> mtrr: 0xd0000000,0x8000000 overlaps existing 0xd0000000,0x200000

Well, don'T use framebuffer console and everthing will be fine.

Prakash
