Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286977AbRL1Sv5>; Fri, 28 Dec 2001 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286979AbRL1Svs>; Fri, 28 Dec 2001 13:51:48 -0500
Received: from brick.homesquared.com ([216.177.65.65]:11740 "EHLO
	brick.homesquared.com") by vger.kernel.org with ESMTP
	id <S286977AbRL1Svl>; Fri, 28 Dec 2001 13:51:41 -0500
Message-ID: <00cd01c18fd0$ced54f20$d90aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Ben Greear" <greearb@candelatech.com>, "Tim Hockin" <thockin@sun.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <arjanv@redhat.com>, <saw@sw-soft.com>, <sparker@sparker.net>
In-Reply-To: <E167w6n-0001dz-00@fenrus.demon.nl> <3C0D54DF.4E897B70@sun.com> <3C269FF1.5040402@candelatech.com>
Subject: Re: [PATCH] eepro100 - need testers
Date: Fri, 28 Dec 2001 10:52:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a friend who has had headaches with a D815EEA board with a 2nd
eepro100+ nic installed.
He compiled a new kernel and used a driver from intel's website, and it's
all good now.
FYI
----- Original Message -----
From: "Ben Greear" <greearb@candelatech.com>
To: "Tim Hockin" <thockin@sun.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>;
<arjanv@redhat.com>; <saw@sw-soft.com>; <sparker@sparker.net>
Sent: Sunday, December 23, 2001 7:24 PM
Subject: Re: [PATCH] eepro100 - need testers


> I just tried this patch against the 2.4.17 kernel.  I was able to
> completely freeze my D815EEA2 motherboard based computer by trying
> to copy a large directory over NFS.  The machine is connected to a
> 10bt HUB, and this setup has shown lockups before with various
> eepro100 drivers.  The e100 seems to work fine in this setup...
>
> An older eepro driver (the one with RH's 2.4.9-13 kernel) does not
> lock up the machine, but I do see incessant wait-for-cmd-done-timeout
> messages, and the network is basically un-usable.
>
> On other machines, connected to a 100bt-FD switch, the new patch
> seems to work just fine, btw.
>
> The eepro lockup is repeatable, so let me know if there is any
> information I can get for you that will help.
>
> Thanks,
> Ben
>
> Tim Hockin wrote:
>
> > This patch was developed here to resolve a number of eepro100 issues we
> > were seeing. I'd like to get people to try this on their eepro100 chips
and
> > beat on it for a while.
> >
> > volunteers?
>
>
> --
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

