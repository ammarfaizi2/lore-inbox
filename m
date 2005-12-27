Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVL0RrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVL0RrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVL0RrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:47:25 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:53943 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751127AbVL0RrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:47:25 -0500
Subject: Re: Machine Check Exception !
From: Lee Revell <rlrevell@joe-job.com>
To: Nauman Tahir <nauman.tahir@gmail.com>
Cc: "Legend W." <mrwangxc@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <f0309ff0512262246q38f9f29l7e58a40c337ede75@mail.gmail.com>
References: <71a51c440512261852u593a2795y@mail.gmail.com>
	 <f0309ff0512262246q38f9f29l7e58a40c337ede75@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 12:51:03 -0500
Message-Id: <1135705865.21981.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 11:46 +0500, Nauman Tahir wrote:
> On 12/27/05, Legend W. <mrwangxc@gmail.com> wrote:
> > Hello,
> >
> > I get the following message under 2.4.21 from RedHat:
> >
> > CPU 3: Machine Check Exception: 0000000000000004
> > <Bank 0: b20000001040080f
> >
> > and the box is dead.
> >
> > When i use parsemce, it said:
> > Status: (4) Machine Check in progress.
> > Restart IP invalid.
> > parsebank(0): b20000001040080f @ 3
> >         External tag parity error
> >         CPU state corrupt. Restart not possible
> >         Error enabled in control register
> >         Error not corrected.
> >         Bus and interconnect error
> >         Participation: Local processor originated request
> >         Timeout: Request did not timeout
> >         Request: Generic error
> >         Transaction type : Invalid
> >         Memory/IO : Other
> >
> > Can anybody please enlighten me what this means or what a possible
> > problem behind might be?
> >
> > Thank you in advance
> >
> > PS: my box has dual Xeon 2.8G CPU
> 
> if you want to make your machine run any way use "nomce" at boot
> prompt against your respective grub entry.

This is a terrible idea.  MCEs indicate some kind of hardware problem,
it would be idiotic to just ignore that.

Figure out the hardware problem and fix it (bad RAM, overheating, poorly
seated card, etc).

Lee

