Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130582AbQJ2DEu>; Sat, 28 Oct 2000 23:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130700AbQJ2DEk>; Sat, 28 Oct 2000 23:04:40 -0400
Received: from z211-19-80-152.dialup.wakwak.ne.jp ([211.19.80.152]:41464 "EHLO
	220fx.luky.org") by vger.kernel.org with ESMTP id <S130582AbQJ2DEX>;
	Sat, 28 Oct 2000 23:04:23 -0400
To: axboe@suse.de
Cc: shibata@luky.org, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
In-Reply-To: <20001028134056.J3919@suse.de>
In-Reply-To: <20001028000448.D3919@suse.de>
	<20001028232703S.shibata@luky.org>
	<20001028134056.J3919@suse.de>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001029120703Y.shibata@luky.org>
Date: Sun, 29 Oct 2000 12:07:03 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, again.

> On Sat, Oct 28 2000, Hisaaki Shibata wrote:
> > > > But I could not mkudf nor mkext2fs to my ATAPI 9.4GB new DVD-RAM drive.
> > > 
> > > What do you mean? What happened? strace of mke2fs of mkudf would
> > > be nice to have.
> > 
> > My system said it is not permited because it is read only.
> 
> [snip]
> 
> Ok, does /proc/sys/dev/cdrom/info list DVD-RAM as a capability?

Yes.
I think it seems good.

# more info 
CD-ROM information, Id: cdrom.c 3.12 2000/10/22

drive name:             hdc
drive speed:            0
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         0
Can write CD-RW:        0
Can read DVD:           1
Can write DVD-R:        0
Can write DVD-RAM:      1

> > And  /proc/ide/hdc/media says "cdrom". Is it OK?
> 
> Yes, that is fine.

OK.

Should I set any flags to permit write a DVD-RAM media ?

Best Regards,

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata
0(mmm)0 P-mail: 070-5419-3233    IRC: #luky
   ~    http://his.luky.org/ last update:2000.3.12
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
