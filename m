Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTAJN13>; Fri, 10 Jan 2003 08:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTAJN13>; Fri, 10 Jan 2003 08:27:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54743 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264992AbTAJN13>; Fri, 10 Jan 2003 08:27:29 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301101336.h0ADaDG10038@devserv.devel.redhat.com>
Subject: Re: 2.4.19 -- ac97_codec failure ALi 5451
To: peter@cogweb.net (Peter)
Date: Fri, 10 Jan 2003 08:36:13 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, alan@redhat.com (Alan Cox)
In-Reply-To: <1042204553.3e1ec789564b6@webmail.cogweb.net> from "Peter" at Jan 10, 2003 05:15:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've downloaded the latest driver and am running 2.4.20 (yea!) -- the trident.c here 
> is actually more recent than 2.5.55. It now loads fast and with no protest from 
> ac97_codec, which has a new ID (ADS114). However, there's still not a peep (I try 
> cat test.mp3 > /dev/dsp) -- and when KDE Control Center tries to restart the arts 
> sound server, it alarmingly fails on "CPU overload" or just freezes the whole 
> system. Is there anything I can do to get more information about what is not 
> happening?

No but the info is very useful. The key change involving ac97 is that the
new code in 2.4.x waits much longer for the codec reset to finish. I'm not
sure where the audio has gone however 8(

