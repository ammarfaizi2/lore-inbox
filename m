Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263366AbUEGInR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUEGInR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUEGImn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:42:43 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:16144 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263325AbUEGIiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:38:09 -0400
Date: Thu, 6 May 2004 23:34:50 +0200
From: DervishD <raul@pleyades.net>
To: linux-kernel@vger.kernel.org
Subject: Re: events kthread gone crazy
Message-ID: <20040506213450.GA11761@DervishD>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040506211934.GA1452@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040506211934.GA1452@fargo>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

 * Davilín <david@pleyades.net> dixit:
> I'm running kernel 2.6.5. I had running aMule and decided to preview
> a file, using xine. Then, suddenly, xine opened but hanged and the
> machine started to feel unresponsive and sluggish. I guessed that
> the xine process was in D state, so i did a 'ps' and found this mess:
[...]
> 11569 ?        SW<    0:00  \_ [events/0]
> 11570 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
> 11571 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
[Ad infinitum]

    It seems that ALSA is screwing something. Maybe you need to
recompile ALSA binaries or something like that :???

>    85 tty3     S      0:00 into           

    What the hell is that crap? X''DDDD

> 11560 tty1     D      0:01 xine /home/huma/.aMule/Temp/006.part

    Have you seen where xine is disk sleeping. It should not matter
to the sound problem, but...

> Any ideas about the cause of this problem?

    Apart from the ALSA cause, I don't have the slightest idea :(
    Good luck.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
