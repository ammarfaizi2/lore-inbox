Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261714AbSKCKLK>; Sun, 3 Nov 2002 05:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbSKCKLK>; Sun, 3 Nov 2002 05:11:10 -0500
Received: from khms.westfalen.de ([62.153.201.243]:12702 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S261714AbSKCKLK>; Sun, 3 Nov 2002 05:11:10 -0500
Date: 03 Nov 2002 10:59:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8$A6Ivu1w-B@khms.westfalen.de>
In-Reply-To: <200211030736.gA37a2lv007213@habitrail.home.fools-errant.com>
Subject: Re: Filesystem Capabilities in 2.6?
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.44.0211021925230.2382-100000@home.transmeta.com> <200211030736.gA37a2lv007213@habitrail.home.fools-errant.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hacksaw@hacksaw.org (Hacksaw)  wrote on 03.11.02 in <200211030736.gA37a2lv007213@habitrail.home.fools-errant.com>:

> As a sys-admin I love the idea of the capabilities, but I hate this mount
> --bind thing. I'd really rather see it have its own command name. If it were
> strictly something that happens at mount time for a filesystem that'd be one
> thing, but
>
> >mount --bind --capability=xx,yy /usr/bin/foo /usr/bin/foo
>
> looks like a mistake.
>
> If you were loop mounting the binary into the user's directory, then I could
> see using mount.
>
> This would be clearer:
>
> setcap -c xx,yy /usr/bin/foo
>
> (I also have nothing against long option names.)

As a sysadmin, this should be about 20 seconds with your favourite editor  
to create a "setcap" shell script.

MfG Kai
