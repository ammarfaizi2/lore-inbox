Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSKOFMz>; Fri, 15 Nov 2002 00:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbSKOFMz>; Fri, 15 Nov 2002 00:12:55 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:39693 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265787AbSKOFMw>; Fri, 15 Nov 2002 00:12:52 -0500
Date: Fri, 15 Nov 2002 05:19:39 +0000
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       Dipankar Sarma <dipankar@gamebox.net>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021115051939.GA32131@compsoc.man.ac.uk>
References: <3DD47858.3060404@mvista.com> <20021115051207.GA29779@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115051207.GA29779@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18CYtI-00027K-00*69KhBRR9VZ6* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 05:12:07AM +0000, John Levon wrote:

> also, the diff would be much easier to read as a separate "mv nmi.c
> nmi_watchdog.c" then diff against that

Oh, and I suppose I agree with Zwane - stuff like this really needs
hammering wrt testing. Have you actually tried oprofile against it
yourself Corey ? It's probably the best source of huge amounts of NMIs
:)

If you can fix up the patch I'll try and make some time to test it
properly

regards
john
-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
