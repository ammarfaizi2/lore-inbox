Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbTH1PsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTH1PsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:48:09 -0400
Received: from ns.tasking.nl ([195.193.207.2]:9476 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S264048AbTH1PsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:48:07 -0400
To: linux-kernel@vger.kernel.org
Message-ID: <3F4E23EC.6080609@_netscape_._net_>
Date: Thu, 28 Aug 2003 17:46:52 +0200
From: David Zaffiro <davzaffiro@tasking.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021220 Debian/1.2.1-3
X-Accept-Language: nl, en-us
MIME-Version: 1.0
Subject: Re: Looking for tunable hardware parameters in 2.4.22
References: <200308262313.h7QNDKIu007249@twopit.underworld>
In-Reply-To: <200308262313.h7QNDKIu007249@twopit.underworld>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Host: 172.17.1.72
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This board has suddenly become unstable when there is a CPU in what
> the motherboard calls "slot 2" and when the FSB is 133 MHz. The
> motherboard is fine when either:
> a) both CPUs are installed, and the FSB is set to 100 MHz, or
> b) the CPU is removed from slot 2 and the FSB is set to 133 MHz.
> 
> I've swapped the CPUs around and tried replacing them entirely to no
> avail, and so I know these CPUs are OK. I've also run memtest 3.0 over
> the memory for almost 6 hours (with FSB=133 MHz; 3 times through the
> entire RAM) with no problems, so I'm sure the RAM is OK too.

I'm probably of no use to you at all, but there's a slight chance that you're suffering from the same problem as I did a while ago... Since two CPU's at 100MHz consume less power than at 133MHz, it just might be that your PSU doesn't deliver enough power, you could messure the voltages and check this... I've suffered from that problem, buying a more powerfull 350W PSU *really* helped me...

Of course there's also a chance that it's somewhat software related... ;-)


