Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWDZTG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWDZTG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWDZTG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:06:59 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:35508 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S964832AbWDZTG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:06:58 -0400
Date: Wed, 26 Apr 2006 15:06:57 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Highpoint SATA RAID (khe khe) status -- oopses, crashes, etc
Message-ID: <20060426190657.GA17639@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060425172356.GD15201@washoe.onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425172356.GD15201@washoe.onerussian.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a follow up: kernels <= 2.6.7 seems to be ok, ie they detect
underlying drives without oopsing (tested 2.6.6 amd64 and 2.6.7 i386)

details are available for kernel 2.6.7 from
http://www.onerussian.com/Linux/bugs/hpt.bug/2.6.7/

On Tue, 25 Apr 2006, Yaroslav Halchenko wrote:

> Dear Kernel Developers,

> I've search the archive and the web extensively: there were some reports
> from the users of RocketRaid 1520 fakeraid about inability to use
> propriatary drivers as well as their opensource drivers:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113566695101306&w=2
> and leaving the hope reply from Dr.Cox:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113631066409179&w=2

> compiled for amd64:
> 2.6.8 kernel: oopsed but seems to somewhat perform after that
> 2.6.15 kernel:  oopsed during boot (debian installer for some reason
> tried it automatically.... grrr) and then it would halt any insmod of
> any IDE driver

> Details on my system and boot/install process can be found from
> http://www.onerussian.com/Linux/bugs/hpt.bug/
> This time I was using beta debian etch installer (which supposedly had
> freshier kernel than sarge's 2.6.8)

> Please advise: can I do anything about this crappy card or I better
> setup nfsroot for now and just buy another supported SATA raid card?
> Thank you in advance. I am willing to perform more testing if that is
> necessary/possible
-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07105
Student  Ph.D. @ CS Dept. NJIT
