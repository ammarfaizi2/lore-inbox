Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261437AbSIWXDp>; Mon, 23 Sep 2002 19:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbSIWXDp>; Mon, 23 Sep 2002 19:03:45 -0400
Received: from [64.6.248.2] ([64.6.248.2]:39601 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S261437AbSIWXDo>;
	Mon, 23 Sep 2002 19:03:44 -0400
Date: Mon, 23 Sep 2002 16:08:47 -0700 (PDT)
From: Peter <cogwepeter@cogweb.net>
X-X-Sender: cogwepeter@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
cc: Mark Lord <mlord@pobox.com>
Subject: Re: hdparm -Y hangup
Message-ID: <Pine.LNX.4.44.0209231556350.16402-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not so -- we do so care! I get the same behavior on 2.4.19-ac4. 

I ran hdparm -Y /dev/hdd on an IBM 120GB DeskStar. The specs sheet 
recommends no more than 8 hours of power-on a day, so I use it as a backup 
drive. The machine it's on is never turned off.

Clarification: is it the case that hdparm -Y (sleep) will cool the drive 
off better than hdparm -y (suspend)?

I read somewhere that -Y only works on unmounted drives. This appears to 
be false. Comments?

Cheers,
Peter

jbradford@dial.pipex.com wrote,

>> On RH7.3 (2.4.18-3) if I do:
>> $ hdparm -Y /dev/hda
>> $ do stuff and disk spins up
>> $ hdparm -Y /dev/hda
>> $ everything hangs waiting for disk
>                   
>It *IS* a bug, but only Mark Lord, (the hdparm maintainer), and I seem to 
>care about it - everybody else says, "just do hdparm -y instead", which 
>is missing the point.

