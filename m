Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSLTSuJ>; Fri, 20 Dec 2002 13:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264786AbSLTSuJ>; Fri, 20 Dec 2002 13:50:09 -0500
Received: from [81.2.122.30] ([81.2.122.30]:2312 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264766AbSLTSuJ>;
	Fri, 20 Dec 2002 13:50:09 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212201909.gBKJ9xWY002166@darkstar.example.net>
Subject: Re: Right, I tried flashing the BIOS, as suggested, and /still/ can't enable SMART
To: marvin@synapse.net (D.A.M. Revok)
Date: Fri, 20 Dec 2002 19:09:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212201338.45492.marvin@synapse.net> from "D.A.M. Revok" at Dec 20, 2002 01:38:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't boot without having my boot-system on /dev/hde, rather than 
> /dev/hda...

rm /dev/hda
rm /dev/hde
mknod hda b 33 0
mknod hde b 3 0

John.

> I /think/ that if the BIOS can initialize the Promise chip, that it is 
> (theoretically) possible for the kernel to initialize the chip to 
> function correctly, but if Promise /won't allow/ paid-for chips to 
> function in a way that gives us the reliability-system we paid-for, then 
> the simplest solution is:

To do what I did with my Promise card - use the IDE ribbon cable that
came with it, and leave the card in the box on the shelf :-).

John.
