Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSBTBs2>; Tue, 19 Feb 2002 20:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291450AbSBTBsS>; Tue, 19 Feb 2002 20:48:18 -0500
Received: from [203.117.131.12] ([203.117.131.12]:45011 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S290797AbSBTBsH>; Tue, 19 Feb 2002 20:48:07 -0500
Date: Wed, 20 Feb 2002 09:48:00 +0800
Subject: Re: Problems with Radeon Framebuffer
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: linux-kernel@vger.kernel.org
To: Hanno Boeck <hanno@gmx.de>
From: Michael Clark <michael@metaparadigm.com>
In-Reply-To: <20020219234939.0d8597fb.hanno@gmx.de>
Message-Id: <DF415341-25A3-11D6-B291-000393843900@metaparadigm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanno Boeck wrote:

> I have Problems using the radeon Framebuffer on my Notebook. It is a 
> Sony PCG-GR114MK with a Radeon Mobility.
>
> Kernel shows the following message. It only works with vesa-framebuffer.
>
> Feb 19 23:41:54 hannonb kernel: radeonfb: ref_clk=2700, ref_div=60, 
> xclk=16600 from BIOS
> Feb 19 23:41:54 hannonb kernel: radeonfb: panel ID string: 1024x768
> Feb 19 23:41:54 hannonb kernel: radeonfb: detected DFP panel size from 
> BIOS: 1024x768
> Feb 19 23:41:54 hannonb kernel: radeonfb: cannot map FB
>
> Any ideas what I could do?

Did you have vesafb compiled in also (can tell by looking at the entire 
dmesg)? This would explain why radeonfb can't map the framebuffer 
memory. If so, try again without vesafb compiled in.

~mc

