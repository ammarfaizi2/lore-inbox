Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273014AbTG3Qtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273019AbTG3Qtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:49:32 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:37310
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S273014AbTG3Qtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:49:31 -0400
Message-ID: <54974.216.12.38.216.1059583683.squirrel@www.ghz.cc>
In-Reply-To: <20030730122145.77592840.sfr@canb.auug.org.au>
References: <20030730110548.73919ca0.sfr@canb.auug.org.au><82E003DC-C22E-11D7-BB43-003065DC6B50@ghz.cc>
    <20030730122145.77592840.sfr@canb.auug.org.au>
Date: Wed, 30 Jul 2003 12:48:03 -0400 (EDT)
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" 
     after2.5.31 (incl. 2.6.0testX)
From: "Charles Lepple" <clepple@ghz.cc>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell said:
> If you get no OOPS from running the above, then you could try the second
> patch below. If your machine still behaves the same way, then you have
> completely ruled out that change to the apm code ... so we need to look
> elsewhere.

I guess it wasn't using that descriptor. The machine behaved the same way
as before when I tested each patch ("unable to enter requested state", and
system comes back to normal).

While experimenting, I noticed something else: in the cases where a system
suspend failed ('apm -s', closing the lid, or activating IBM's hibernate
mode), a 'system standby' request worked. Trying to transition from
standby to suspend does not work, however-- the laptop wakes up, and
eventually prints the same error message as for a normal suspend.

thanks for the patch,

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
