Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290553AbSAYExP>; Thu, 24 Jan 2002 23:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290557AbSAYExC>; Thu, 24 Jan 2002 23:53:02 -0500
Received: from gpo.cisco.com ([64.104.243.139]:27275 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S290553AbSAYEwj>;
	Thu, 24 Jan 2002 23:52:39 -0500
Message-ID: <3C50E480.6B5F7591@cisco.com>
Date: Fri, 25 Jan 2002 15:52:16 +1100
From: Richard Kinder <rkinder@cisco.com>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD   (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Lost Logic <lostlogic@lostlogicx.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Corruption under 2.4.18-pre6-O1J5 [+2.4.17]
In-Reply-To: <3C50D104.2050608@lostlogicx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have experienced corruption under 2.4.17 similar to this, not massive, but
enough corruption to severely restrict operation - files in /etc were
corrupted, mtab couldn't be created on boot thus no other drives were mounted.
Machine was shut down properly prior to this, no oopses or other strange
behaviour (other than my inability to get a Sycard PCMCIA adapter working)

I was still able to log in as root and force a check of / on next reboot,
which fixed the problem up (about 3 files were cleared, including mtab, IIRC).

Config file/system details available if anyone is interested.

Regards,
    Richard

Lost Logic wrote:

> I use Reiserfs for all of my partitions, and soon after upgrading to
> linux-2.4.18-pre6-O1J5 I started getting massive data corruption in my
> /etc directory, strangely enough ONLY in that directory.  I've attached
> the .config I used for that kernel, unfortunately I have been unable to
> do further testing, because at the same time I had problems on my
> production box, and had to use my toy box to fix it (so I couldn't
> afford to have my toy box down any more).
>
> Hope this is helpful/interesting!
>
> --Brandon

