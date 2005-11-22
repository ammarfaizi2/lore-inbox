Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVKVBVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVKVBVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVKVBVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:21:22 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:20426 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964817AbVKVBVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:21:21 -0500
Date: Tue, 22 Nov 2005 01:21:18 +0000 (GMT)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Alexander Clouter <alex@digriz.org.uk>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, blaisorblade@yahoo.it,
       davej@codemonkey.org.uk, davej@redhat.com
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of
 'ignore nice'
In-Reply-To: <20051121181722.GA2599@inskipp.digriz.org.uk>
Message-ID: <Pine.LNX.4.63.0511220102330.18504@deepthought.mydomain>
References: <20051121181722.GA2599@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1527206152-1132622478=:18504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1527206152-1132622478=:18504
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 21 Nov 2005, Alexander Clouter wrote:

> The use of the 'ignore_nice' sysfs file is confusing to anyone using it. This
> removes the sysfs file 'ignore_nice' and in its place creates a
> 'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes are
> not counted towards the 'business' calculation.
>
> WARNING: this obvious breaks any userland tools that expected ignore_nice' to
> exist, to draw attention to this fact it was concluded on the mailing list
> that the entry should be removed altogether so the userland app breaks and so
> the author can build simple to detect workaround.  Having said that it seems
> currently very few tools even make use of this functionality; all I could
> find was a Gentoo Wiki entry.
>
> Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>
>

  Great.  I get to rewrite my initscript for the ondemand governor to 
test for yet another kernel version, and write a 0 to yet another sysfs 
file, just so that any compile I start in an xterm on my desktop box can 
make the processor work for its living.

  Just what have you cpufreq guys got against nice'd processes ?  It's 
enough to drive a man to powernowd ;)

Ken
--
  das eine Mal als Tragödie, das andere Mal als Farce

---1463809536-1527206152-1132622478=:18504--
