Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSBOHzf>; Fri, 15 Feb 2002 02:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287578AbSBOHz0>; Fri, 15 Feb 2002 02:55:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40210 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287545AbSBOHzJ>;
	Fri, 15 Feb 2002 02:55:09 -0500
Message-ID: <3C6CBEDA.DB6BDA50@mandrakesoft.com>
Date: Fri, 15 Feb 2002 02:55:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Luigi Genoni <kernel@Expansa.sns.it>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: cleanup for i810 chipset for 2.5.5-pre1. Second...
In-Reply-To: <Pine.LNX.4.44.0202141819080.30210-100000@Expansa.sns.it> <3C6CB8DD.9040602@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Luigi Genoni wrote:
> 
> >Well, my mailer did some bad things with tabs, spaces and so on...
> >What can I say, I hate when it happens, I hope this time is the good one.
> >
> 
> Well better take this, it should make even DM and JG as well as other
> "portability" fanatics happy ;-).
> And as a bonus I'm just adding a fixing note to the documentation, which
> by the way is
> no longer accurate.

Well, I've mentioned this at least three times, Pete Zaitcev has a patch
which fixes i810_audio properly -- and he even posted it to lkml less
than 24 hours ago.  Subject "Re: 2.5.5-pre1 and i810_audio.c",
message-id <200202141842.g1EIgcR12566@devserv.devel.redhat.com>

Further, Alan Cox pointed out that the i810_audio workalike chipsets
exist on Alpha, so your solution is still non-portable specifically for
case where portability is needed.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
