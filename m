Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271808AbRHRLHs>; Sat, 18 Aug 2001 07:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRHRLHk>; Sat, 18 Aug 2001 07:07:40 -0400
Received: from smtp-server1.tampabay.rr.com ([65.32.1.34]:49840 "EHLO
	smtp-server1.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S271808AbRHRLHU>; Sat, 18 Aug 2001 07:07:20 -0400
Message-ID: <018901c127d5$fadba320$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: "Dewet Diener" <linux-kernel@dewet.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010818030321.A11649@darkwing.flatlit.net>
Subject: Re: ext3 partition unmountable
Date: Sat, 18 Aug 2001 07:07:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I'm reading the files right it looks like:
#define EXT3_FEATURE_INCOMPAT_COMPRESSION  0x0001

Did you compress the file system?

Do a "tune2fs -l /dev/hdc" and see what features are set.

----- Original Message -----
From: "Dewet Diener" <linux-kernel@dewet.org>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, August 17, 2001 9:03 PM
Subject: ext3 partition unmountable


> Hi all
>
> After umounting a removable ext3 partition from my work PC, and
> trying to remount it at home, I've run into the following error
> trying to mount it as both ext2 and ext3:
>
> EXT2-fs: ide1(22,65): couldn't mount because of unsupported optional
features (10000).
> EXT3-fs: ide1(22,65): couldn't mount because of unsupported optional
features (10000).
>
> e2fsck is similarly unhelpful:
> e2fsck: Filesystem has unsupported feature(s) while trying to open
/dev/hdd1
>
> The kernels on both machines have the same ext3 options enabled, and
> they're both 2.4.8-ac6.
>
> This is the first time I've tried moving the drive like this - I
> assumed it would work flawlessly.  However, ext3 doco seems a bit
> sparse under Documentation/, so I'm not quite sure about the recovery
> steps needed.
>
> I'd appreciate your help on this one :)  Please CC me in...
>
> Regards,
> Dewet
>
> --
> Dewet Diener     dewet@itouchlabs.com     -o)
> Systems Administrator     iTouch Labs     / \
> Self-confessed geek and Linux fanatic    _\_v
>
> SYN! ..... SYN! ACK! ..... ACK!
> The mating call of the internet
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

