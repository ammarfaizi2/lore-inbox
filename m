Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRHaPzZ>; Fri, 31 Aug 2001 11:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbRHaPzO>; Fri, 31 Aug 2001 11:55:14 -0400
Received: from mercury.ultramaster.com ([208.222.81.163]:23196 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S267043AbRHaPzE>; Fri, 31 Aug 2001 11:55:04 -0400
Date: Fri, 31 Aug 2001 12:02:55 -0400 (EDT)
From: <david@ultramaster.com>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac1 RAID-5 resync causes PPP connection to be unusable
Message-ID: <Pine.LNX.4.33.0108311158440.24063-100000@mercury.ultramaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Kevin P. Fleming" <kevin@labsysgrp.com>  wrote:
> OK, I see that now... and it looks like the risks associated with
> setting the unmaskirq flags on my drives (none of the four drives have
> it set now) are too great to be worth playing with it. I'll just not
> use my PPP connection during these particularly heavy disk activity
> moments. Thanks for the quick response.

I don't think that the unmask irq thing is really a problem for any modern
system.  Since the days of 1.2 I've run every system with -u 1.  It's not
a case of: '-u 1' gives a .01% chance of corruption on any system, instead
it's a case of '-u 1' gives a 100% chance of corruption on certain
systems, see the difference?

In short, try the -u 1 cautiously (maybe on a r/o fs, or have backups) if
you're paranoid, but if your system is modern, have no fears.

DISCLAIMER: *if* your system does eat itself, it wasn't me that told you
it wouldn't.

David



-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com

