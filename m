Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270194AbRHSIDf>; Sun, 19 Aug 2001 04:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270250AbRHSID0>; Sun, 19 Aug 2001 04:03:26 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:14853 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S270194AbRHSIDQ>; Sun, 19 Aug 2001 04:03:16 -0400
Date: Sun, 19 Aug 2001 16:04:35 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Paul <set@pobox.com>
cc: Jeff Chua <jchua@fedex.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
In-Reply-To: <20010819014049.A1315@squish.home.loc>
Message-ID: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Aug 2001, Paul wrote:
> 	Actually, it works fine for me too, _if_ I use DOS 5 as
> the boot image, but I changed to DOS 6.22, and its has oops'd
> every time Ive tried it that way. Its just a trigger for whatever
> the real problem is.
>
> Paul
> set@pobox.com

I'm using dosemu-1.1.1.tgz with Windows 98 [Version 4.10.2222]

Does "dos" command works for you instead of "xdos" ?

Did you check your shmmax?

Try ...
	echo 1000000000 >/proc/sys/kernel/shmmax



Jeff

