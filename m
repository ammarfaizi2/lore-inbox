Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266658AbUBFIGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 03:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUBFIGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 03:06:13 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:11465 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266658AbUBFIGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 03:06:09 -0500
From: Walt Nelson <wnelsonjr@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Fri, 6 Feb 2004 00:06:32 -0800
User-Agent: KMail/1.6
References: <200402041820.39742.wnelsonjr@comcast.net> <20040205171028.652a694c.mikeserv@bmts.com> <20040206021522.12dfd362.mikeserv@bmts.com>
In-Reply-To: <20040206021522.12dfd362.mikeserv@bmts.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402060006.32732.wnelsonjr@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure but patch-2.6.2-bk1.tar.gz has not produce the mouse problems. I 
applied it about 14 hours ago. I have no seen any mouse problems. I noticed 
that there was a possible fix for loosing ticks in it?

Walt


On Thursday 05 February 2004 11:15 pm, Mike Houston wrote:
> On Thu, 5 Feb 2004 17:10:27 -0500
>
> Mike Houston <mikeserv@bmts.com> wrote:
> > I am using ACPI and IO-APIC. Next time my mouse acts up, I will consider
> > trying 2.6.2 without ACPI and IO-APIC (though I'd hate to lose that
> > functionality). Trouble is it might take a long time for the mouse glitch
> > to occur.
>
> Ok, shortly after posting earlier today, it did indeed happen again with
> 2.6.2. I was just clicking on mails in my sylpheed client. There wasn't
> much load, I wasn't doing anything but reading mails.
>
> So I built another 2.6.2 with acpi and io-apic disabled and ran it for
> about 5 hours and the problem reoccurred. I was just chatting on IRC and
> moved my mouse and it happened. Again, I was doing nothing else so load
> wasn't a factor.
>
> psmouse.c: MX Mouse at isa0060/serio1/input0 lost synchronization, throwing
> 2 bytes away.
>
> Gee whiz, it just happened again while composing this mail :-)
>
> So it doesn't have anything to do with acpi, or being under load for that
> matter, on my system, anyway.
>
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
