Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131461AbRDCMyC>; Tue, 3 Apr 2001 08:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDCMxw>; Tue, 3 Apr 2001 08:53:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41477 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131461AbRDCMxp>; Tue, 3 Apr 2001 08:53:45 -0400
Subject: Re: Larger dev_t
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Tue, 3 Apr 2001 13:53:22 +0100 (BST)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        alan@lxorguk.ukuu.org.uk (Alan Cox), Andries.Brouwer@cwi.nl,
        torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <3AC9BEEF.A2EC0CA@evision-ventures.com> from "Martin Dalecki" at Apr 03, 2001 02:15:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kQJI-00081v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > One thing I certainly miss: DevFS is not mandatory (yet).
> 
> That's "only" due to the fact that DevFS is an insanely racy and
> instable
> piece of CRAP. I'm unhappy it's there anyway...

It certainly seems to have some race conditions but other than that and the
slight problem it puts policy in the kernel it seems ok. I'd prefer it was
userspace and implemented via /sbin/hotplug - but that isnt possible yet and
opens a whole other set of interesting races to ponder

