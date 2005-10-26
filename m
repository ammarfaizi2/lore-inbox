Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVJZTiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVJZTiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVJZTiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:38:06 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:5781 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S964884AbVJZTiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:38:05 -0400
Date: Wed, 26 Oct 2005 21:38:01 +0200
From: Sander <sander@humilis.net>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org, sander@humilis.net,
       Avuton Olrich <avuton@gmail.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: EDAC (was: Re: 2.6.14-rc5-mm1)
Message-ID: <20051026193800.GA15552@favonius>
Reply-To: sander@humilis.net
References: <20051026131157.GA12963@favonius> <20051026190838.85701.qmail@web50111.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026190838.85701.qmail@web50111.mail.yahoo.com>
X-Uptime: 21:21:20 up 81 days,  6:45, 37 users,  load average: 1.52, 1.95, 1.94
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Thompson wrote (ao):
> --- Sander <sander@humilis.net> wrote:
> > Via Epia MII 10000, kernel 2.6.14-rc4-mm1:
 
> The EDAC scanning code first scans the STATUS register
> of all the PCI devices in the system. This status
> register reflects operations on the main bus.
> Second, the code scans the SECONDARY STATUS register
> of all bridge devices, which reflects operations on
> the sub-bus.
> 
> This instance (0000:00:01.0) of output shows me the
> VIA VT8633 is generating the parity bit. The default
> poll interval if 1000 ms and the above output shows
> this. This bridge is either having a parity error on
> the main bus OR more likely is generating false
> positives. How to determine which? More investigation
> is needed.  

Anything I can do? And will blacklisting make EDAC useless? If so, does
it make more sense not to configure EDAC?

-- 
Humilis IT Services and Solutions
http://www.humilis.net
