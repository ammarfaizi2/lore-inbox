Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSHITeb>; Fri, 9 Aug 2002 15:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSHITeb>; Fri, 9 Aug 2002 15:34:31 -0400
Received: from 62-190-216-72.pdu.pipex.net ([62.190.216.72]:49924 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S313060AbSHITea>; Fri, 9 Aug 2002 15:34:30 -0400
From: jbradford@dial.pipex.com
Message-Id: <200208091944.g79JiTNL000542@darkstar.example.net>
Subject: Re: No reset of IDE disk
To: diegocg@teleline.es (Arador)
Date: Fri, 9 Aug 2002 20:44:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020809201020.37c81b75.diegocg@teleline.es> from "Arador" at Aug 09, 2002 08:10:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I posted the same message as you some weeks ago.

Sorry for the wasted bandwidth then - I am usually subscribed to the list, but temporarily de-subscribed for the last week.

> People said me that
> after a -Y you must always do a -w. Yes, the manpage can say that the
> kernel should do a -w of needed...but perhaps the man page is out of
> date...people here should know more...

Hmmm, the man page may well be out of date.

However, I would have thought that anything that stalls the IDE queue was to be considered a bug.  I've E-Mailed Mark Lord, (the hdparm maintainer), to get some more input on this.

The interesting thing is that it does automatically recover from a -Y on the laptop running 2.4.19, (as it did with 2.2.13).

> the -w is the hard soft reset i think ;)

Yeah, it's a device reset.

> I was told to use -y. And it works well. I dont know the differences
> between -y and -Y (apparently, it should do the same ;)

Well, as far as I know, -y is intended to be a fast recovery, whereas -Y is more or less a full shut down, somewhat analogous to the various levels of power saving implemented in DPMS-compliant "green" monitors.

Somewhat related to all this, I am interested in having a variable delay in the write-back caching, (yeah, I know, keeping data cached in RAM on a battery powered laptop is asking for it to get lost, but I'd like the option), that way I could spin the HD down and enjoy a much extended battery life.
