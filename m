Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQKNVOH>; Tue, 14 Nov 2000 16:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130201AbQKNVN5>; Tue, 14 Nov 2000 16:13:57 -0500
Received: from [209.143.110.29] ([209.143.110.29]:35592 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S129455AbQKNVNs>; Tue, 14 Nov 2000 16:13:48 -0500
Message-ID: <3A11A3FC.201F26D0@the-rileys.net>
Date: Tue, 14 Nov 2000 15:43:45 -0500
From: David Riley <oscar@the-rileys.net>
X-Mailer: Mozilla 4.74 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: "Stephen Gutknecht (linux-kernel)" <linux-kernel@i405.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: newbie, 2.4.0 on Asus CUSL2 (Intel 815E chipset with onboard video)
In-Reply-To: <0066CB04D783714B88D83397CCBCA0CD4963@spike2.i405.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen Gutknecht (linux-kernel)" wrote:
> 
> Thanks for the prior help on getting the kernel to compile; real newbie
> mistake of not finding the right options in the "make menuconfig" screens.
> 
> I can now compile 2.4.0-test, but it hangs on the first line of loading.
> 
>  -- I have tried 2.4.0-test10 and 2.4.0-test11-pre4
>  -- If I only do my network adapter, it compiles and boots fine.  It is when
> I add my desired settings (via "make menuconfig") for video support that the
> compiled kernel hangs at system boot.
> 
> I have documented the exact procedure I use to compile the kernel at:
> 
>   http://www.roundsparrow.com/Linux/240oni815/

In your document, you don't mention any setting of CPU type.  That would
be right above the SMP setting.  You say you have a celeron... the
default processor setting is P3, and there's a different setting for
PPro/P2/Celerons.  Improper processor selection has caused a bundle of
rather abrupt and unexplained hangs for me...

BTW, you could compile the RTL8139 driver into the kernel... It works
fine for me.  For what it's worth.  Nothing wrong with modules anyway...

	David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
