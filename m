Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbREOVYS>; Tue, 15 May 2001 17:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261562AbREOVYL>; Tue, 15 May 2001 17:24:11 -0400
Received: from WARSL401PIP5.highway.telekom.at ([195.3.96.112]:41522 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S261559AbREOVW7>;
	Tue, 15 May 2001 17:22:59 -0400
Message-ID: <3B019E1C.9D9CE388@violin.dyndns.org>
Date: Tue, 15 May 2001 23:22:36 +0200
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
Reply-To: dusty@strike.wu-wien.ac.at
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Interrupted sound with 2.4.4-ac6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At first I have to apologize if you get this mail double, I sent it
yesterday once but I did not get it from the list and it seems it
vanished for some reason, so I try it a second time:

I built a nice mp3 player out of a AMD 486-DX133 and a soundblaster
es1371. I always used 2.2.16 and it worked properly. Due to several
reasons I want to switch to 2.4, so I tried my luck with 2.4.4-ac6.

Basically it works but the sound gets interrupted (around 0.5 - 5seconds
silence) from time to time although the system is around 44% idle. This
never happened with 2.2.16. These interrupts are not periodically,
sometimes there are none for a minute, sometimes there are even
interrupts around 5 seconds long.

I have to state that the data comes from an nfs-mounted directory -
perhaps this is a reason? (There is no network load).

Another interesting thing is that during those interrupts the processor
usage of mpg123 decreases from 53% to around 20%, so it looks as if
mpg123 can either not get data or not output data.

Do you have any clues? Are there perhaps some kernel parameters to tune
(buffer size, dma...)?

                Best Regards,
                Hermann
-- 
 ,_,
(O,O)     "There is more to life than increasing its speed."
(   )     -- Gandhi
-"-"--------------------------------------------------------------
