Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVHBPqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVHBPqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVHBPoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:44:23 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:49092 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261575AbVHBPm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:42:56 -0400
Message-ID: <42EF947E.1070600@andrew.cmu.edu>
Date: Tue, 02 Aug 2005 11:42:54 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sclark46@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu> <20050801204245.GC17258@thunk.org> <42EEFB9B.10508@andrew.cmu.edu> <42EF70BD.7070804@earthlink.net>
In-Reply-To: <42EF70BD.7070804@earthlink.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark wrote:
> Maybe new desktop systems - but what about the tens of millions of old 
> systems that don't.

If it's an old system, it probably doesn't have working ACPI C-states 
though.  Without that, low HZ does not save you anything.  I should have 
said: 99% of desktops with the capability to do ACPI sleep have at least 
one USB device attached (usually a mouse).

I do like saving power, which is why I run cpu frequency scaling on 
every machine I have that supports it.  I'm happy because it does its 
savings without negatively impacting latency or high-load performance. 
By 2.6.14 dyntick should give us the same thing for HZ, which is why I 
think changing the maximum value now doesn't make sense.

  - Jim Bruce
