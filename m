Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUARUtC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 15:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUARUtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 15:49:02 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:46816 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263606AbUARUs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 15:48:59 -0500
From: Willem Riede <wrlk@riede.org>
Subject: Re: Making MO drive work with ide-cd
Date: Sun, 18 Jan 2004 15:48:56 -0500
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2004.01.18.20.48.54.969059@riede.org>
References: <UTC200401181220.i0ICKpx05161.aeb@smtp.cwi.nl>
Reply-To: wrlk@riede.org
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jan 2004 13:20:51 +0100, Andries.Brouwer wrote:

>     From der.eremit@email.de  Sun Jan 18 02:16:30 2004
>     From: Pascal Schmidt <der.eremit@email.de>
> 
>     Please fill the whole disk and then reread and compare via ide-scsi.
>     That never worked for me in 2.6 using ide-scsi, but it does work
>     with the patch in -mm.
> 
> Yes, you are right. Yesterday night I tried a small amount of I/O,
> and that worked fine, but today the kernel couldn't cope with a diff
> between two 640MB trees.
> Unable to handle kernel paging request at virtual address 6b6b6b6b.
> Followed by a bad kernel crash (vanilla 2.6.1).
> 
> OK. So, just like the rumours said already, ide-scsi is badly broken.
> 
>     By the way, what hardware sector size does your MO use? I have
>     only tested my patch with 2048 byte sector size - everything else
>     is unlikely to work with ide-cd...
> 
> It uses media with 512-byte and media with 2048-byte sectors.
>      
>     > Are there cases where ide-cd is useful?
>     > Should we retarget ide_optical to ide-scsi?
> 
>     I agree that the situation in mainline as it is now is undesirable,
>     only mounting prewritten discs read-only works.
> 
> Yes. We must find out what is wrong in ide-scsi and fix it.

I am trying to maintain ide-scsi so I'm very interested in details
of the crash you observed. Can you post them, or mail directly to
me if that's not appropriate?

Thanks, Willem Riede.

