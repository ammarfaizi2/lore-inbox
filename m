Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136431AbRA1Bmf>; Sat, 27 Jan 2001 20:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136481AbRA1BmO>; Sat, 27 Jan 2001 20:42:14 -0500
Received: from CPE-61-9-150-246.vic.bigpond.net.au ([61.9.150.246]:60166 "EHLO
	halfway") by vger.kernel.org with ESMTP id <S136431AbRA1BmN>;
	Sat, 27 Jan 2001 20:42:13 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Rick Jones <raj@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN 
In-Reply-To: Your message of "Fri, 26 Jan 2001 10:04:36 -0800."
             <3A71BC34.F8024103@cup.hp.com> 
Date: Sat, 27 Jan 2001 18:11:52 +1100
Message-Id: <E14MPWb-0003fb-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A71BC34.F8024103@cup.hp.com> you write:
> I thought that most firewalls were supposed to be insanely paranoid.
> Perhaps it would be considered a possible covert data channel, as
> farfecthed as that may sound.

If they were `insanely paranoid' they wouldn't just be doing packet
filtering.  The firewall designers can't have it both ways.

1) Dropping these packets is wrong, but it won't get fixed if noone
   pressures them to.  Fixing this now also makes future standards
   enhancements easier, by bringing the 'net closer to compliance.

2) Sending RSTs is completely fucked up.  Those firewalls are too
   braindamaged to live.

Distros will probably turn ECN off, but maybe if we fix enough of the
net, later versions may not.

Rusty.
--
Premature optmztion is rt of all evl. --DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
