Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbRCLMqN>; Mon, 12 Mar 2001 07:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130073AbRCLMqD>; Mon, 12 Mar 2001 07:46:03 -0500
Received: from [62.122.5.33] ([62.122.5.33]:1543 "HELO milkplus")
	by vger.kernel.org with SMTP id <S130065AbRCLMp5>;
	Mon, 12 Mar 2001 07:45:57 -0500
Subject: Re: Interesting fs corruption story
From: Ettore Perazzoli <ettore@ximian.com>
To: timw@splhi.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010307122222.A1254@kochanski.internal.splhi.com>
In-Reply-To: <Pine.LNX.4.21.0103042043320.27829-100000@trna.ximian.com>
	<20010306170102.B1095@kochanski.internal.splhi.com>
	<983927410.11517.0.camel@milkplus.unknown.domain> 
	<20010307122222.A1254@kochanski.internal.splhi.com>
Content-Type: text/plain
X-Mailer: Evolution/0.9 (Preview Release)
Date: 12 Mar 2001 07:44:40 -0500
Message-Id: <984401080.15372.4.camel@milkplus.unknown.domain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Mar 2001 12:22:22 -0800, Tim Wright wrote:
> On Tue, Mar 06, 2001 at 08:10:10PM -0500, Ettore Perazzoli wrote:
> > On 06 Mar 2001 17:01:02 -0800, Tim Wright wrote:
> Yes, it does. I have the drive running in UDMA mode 2, and get ~16MB/s from
> 'hdparm -t -T'. I have the "use DMA automatically" option turned on in the
> kernel, so I inherit the BIOS settings which are correct.
> 
> I've used standby and hibernation with complete success since.

  This seemed to fix the problem for me as well.  I have had DMA turned
on since then, and I have experienced no file system corruption anymore.
Thanks!

  Maybe the help message for this kernel option (CONFIG_APM_ALLOW_INTS)
should report in big blocky letters that disabling it might cause major
data loss with some drive/bios combinations?..  I was not aware that I
was touching such a sensitive parameter when I rebuilt the kernel, and
the help message didn't warn me in any way.

-- 
Ettore
