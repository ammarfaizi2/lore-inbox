Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262562AbRENXBq>; Mon, 14 May 2001 19:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262565AbRENXBd>; Mon, 14 May 2001 19:01:33 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:60748 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S262562AbRENXBV>;
	Mon, 14 May 2001 19:01:21 -0400
Message-ID: <3B0063B8.AE6A1A0B@violin.dyndns.org>
Date: Tue, 15 May 2001 01:01:12 +0200
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
Reply-To: dusty@strike.wu-wien.ac.at
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Interrupted sound with 2.4.4-ac6
In-Reply-To: <Pine.GSO.4.21.0105141748180.19333-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I built a nice mp3 player out of a AMD 486-DX133 and a soundblaster
es1371. I always used 2.2.16 and it worked properly. Due to several
reasons I want to switch to 2.4, so I tried my luck with 2.4.4-ac6.

Basically it works but the sound gets interrupted (around 0.5 - 5seconds
silence) from time to time although the system is around 44% idle. This
never happened with 2.2.16. The interrupts are not periodically,
sometimes there are none for a minute, sometimes there are even
interrupts around 5 seconds long.

I have to state that the data comes from an nfs-mounted directory -
perhaps this is a reason?

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
