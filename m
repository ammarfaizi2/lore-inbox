Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277029AbRJDGuH>; Thu, 4 Oct 2001 02:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277139AbRJDGt7>; Thu, 4 Oct 2001 02:49:59 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:16572 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S277029AbRJDGtp>;
	Thu, 4 Oct 2001 02:49:45 -0400
Message-ID: <3BBC06A1.1818E45C@candelatech.com>
Date: Wed, 03 Oct 2001 23:50:09 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110031848220.7244-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

> Your patch with Linus' idea of "flag mask" would be more acceptable as a
> last resort. All subsytems should be cooperative and we resort to this to
> send misbehaving kids to their room.

That requires re-writing all the drivers, right?  Seems a very bad
thing to do in 2.4

> 
> > Your NAPI patch, or any driver/subsystem that does flowcontrol accurately
> > should never be affected by it in any way. No overhead, no performance
> > hit.
> 
> so far your appraoch is that of a shotgun i.e  "let me fire in
> that crowd and i'll hit my target but dont care if i take down a few
> more"; regardless of how noble the reasoning is, it's  as Linus described
> it -- a sledge hammer.

Aye, but by shooting this target and getting a few bystanders, you save
everyone else...  (And it's only a flesh wound!!)

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
