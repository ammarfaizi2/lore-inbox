Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbUBXPsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUBXPsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:48:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:6339 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262261AbUBXPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:48:50 -0500
Message-ID: <403B7245.1000208@t-st.org>
Date: Tue, 24 Feb 2004 16:48:21 +0100
From: Tillmann Steinbrecher <t-st@t-st.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@phunnypharm.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.3 + external firewire dvd writer - frequent freezes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:440c24a95efadc9d8e1374cf9e681760
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I'm using an external FireWire DVD writer (Plextor 708 in case w/Oxford
> > 911 chipset). This was working fine until kernel 2.6.2.
> > 
> > Since I upgraded to 2.6.3, it frequently happens that the system totally
> > freezes when trying to write a DVD. It's really a hard crash, no mouse
> > movement, no ping on the network. Reset required.
> > 
> > It doesn't happen each time I try to burn a DVD, but in about 20% the
> > cases. So basically the writer is unusable with 2.6.3

> Can you enable spinlock debug so we can see if this is a race condition
> somewhere?

Thanks for your reply.  What option do I have to enable exactly? 
CONFIG_DEBUG_SPINLOCK_SLEEP? Anything else required? Also, how do I get 
access to the results of the debugging? I mean, it's really a hard 
crash, no messages visible (that is, when running X), no logging to 
syslog, etc.

Also - can this possibly be related to the "growisofs problem with 
2.6.3" that was discussed at various places (and a patch was posted too) 
- I have this problem, too, since the upgrade to 2.6.3. Just in case you 
havent followed the discussion, here are two links:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&selm=c153vj%242vep%241%40FreeBSD.csie.NCTU.edu.tw
http://groups.google.com/groups?q=growisofs+2.6.3&hl=en&lr=&ie=UTF-8&oe=utf-8&selm=linux.scsi.20040221112550.6aec57eb.mike%40it-loops.com&rnum=4

Right now I can't do tests, since I'm away from home, and if I trigger a 
crash from remote I'm in trouble since I still need the machine; but I'm 
willing to test patches as soon as I'm back.

bye,
Tillmann
