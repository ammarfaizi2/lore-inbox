Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWBTG7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWBTG7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 01:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWBTG7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 01:59:16 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:21436 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932671AbWBTG7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 01:59:16 -0500
Date: Mon, 20 Feb 2006 01:58:36 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Sasha Khapyorsky <sashakh@gmail.com>
cc: s.schmidt@avm.de, Greg KH <greg@kroah.com>, torvalds@osdl.org,
       kkeil@suse.de, LKML <linux-kernel@vger.kernel.org>,
       opensuse-factory@opensuse.org, libusb-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers
 of major vendor excluded
In-Reply-To: <20060220031130.GA9929@khap>
Message-ID: <Pine.LNX.4.58.0602200152340.29913@gandalf.stny.rr.com>
References: <20060205205313.GA9188@kroah.com>
 <OFED05BE20.31E2BACE-ONC1257115.005DE6CA-C1257117.004F2C48@avm.de>
 <20060219045716.GA9880@khap> <Pine.LNX.4.58.0602191158410.12662@gandalf.stny.rr.com>
 <20060220031130.GA9929@khap>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2006, Sasha Khapyorsky wrote:

> On 12:02 Sun 19 Feb     , Steven Rostedt wrote:
> >
> > Disclaimer:  This is in no way a push to get the -rt patch into mainline
> > at the moment.  The patch is still young and is not ready yet.
>
> Hmm, it was not about -rt patch - 40 millisecond response time is
> realistic for userspace even without -rt patch. There is no guarantee,
> but in practice this may work very well and keep low percents of failures
> (much lower than permitted by standards).
>

No the thread was not about the -rt patch, but I just wanted to spread a
little light that it exists.  In fact, besides the current problem with
the SMP scheduler balancing latency (that exists also in mainline) you
should be able to get at least 100us response time on a modest machine.
Even when the IDE wants to hog the CPU.

-- Steve
