Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136538AbRD3XSc>; Mon, 30 Apr 2001 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136532AbRD3XSW>; Mon, 30 Apr 2001 19:18:22 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:39668 "HELO
	giants.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S136538AbRD3XSC>; Mon, 30 Apr 2001 19:18:02 -0400
To: Garett Spencley <gspen@home.com>
Cc: Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 breaks dhcpcd with Realtek 8139
In-Reply-To: <Pine.LNX.4.30.0104281142520.3423-100000@localhost.localdomain>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 01 May 2001 01:16:15 +0100
In-Reply-To: <Pine.LNX.4.30.0104281142520.3423-100000@localhost.localdomain> (Garett Spencley's message of "Sat, 28 Apr 2001 11:44:58 -0400 (EDT)")
Message-ID: <m3hez52ab4.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.090002 (Oort Gnus v0.02) Emacs/21.0.100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Garett Spencley <gspen@home.com> writes:

> On Sat, 28 Apr 2001, Michael F Gordon wrote:
> 
> > dhcpcd stops working if I install 2.4.4.  Replacing the 2.4.4 version of
> > 8139too.c with the 2.4.3 version and leaving everything else exactly
> > the same gets things working again.  Configuring the interface by hand
> > after dhcpcd has timed out also works.  Has anyone else seen this?
> 
> I noticed this in 2.4.3-acX series as well. But here's the funny part:
> When dhcp starts up during bootup it doesn't work. But as
> soon as I log in and do a su -c '/etc/rc.d/init.d/network restart' there's
> instant success!
> 
> This is on Mandrake 8.0
> 
> It doesn't make much sense to me.

you may want to report the bug at :

https://qa.mandrakesoft.com/
