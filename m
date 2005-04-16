Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVDPRNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVDPRNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 13:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVDPRNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 13:13:09 -0400
Received: from swm.pp.se ([195.54.133.5]:38582 "EHLO uplift.swm.pp.se")
	by vger.kernel.org with ESMTP id S262702AbVDPRNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 13:13:06 -0400
Date: Sat, 16 Apr 2005 19:13:03 +0200 (CEST)
From: Mikael Abrahamsson <swmike@swm.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 upgrade overall failure report (me too)
In-Reply-To: <055FPDS12@server5.heliogroup.fr>
Message-ID: <Pine.LNX.4.62.0504161908531.490@uplift.swm.pp.se>
References: <055FPDS12@server5.heliogroup.fr>
Organization: People's Front Against WWW
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2005, Hubert Tonneau wrote:

I just have to second some of the problems you have run into.

> . There is still a memory leak trouble (probably in tigon3 driver since others
>  reported so on kernel mailing list, and tigon3 is not a geek hardware since
>  most nowdays lowend servers use either tigon3 or pro1000)

I tried installing a machine that previously was running redhat 7.3 with 
2.4.something with debian and 2.6 with tg3 driver and it just wouldn't 
even complete the install (debian installer didn't get past detecting the 
hardware). Same debian install with 2.4 worked perfectly.

> . Since 2.6.10, the TCP task does not work anymore with OSX (2 Mbps instead
>  of 60 Mbps on a 100 Mbps wire)

I tried 2.6.11.2 but ran into weird TCP problems as well (intermittent 
timeouts and stalls), 2.6.8.1 works perfectly.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
