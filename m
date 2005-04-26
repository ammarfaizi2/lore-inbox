Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVDZOTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVDZOTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDZOTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:19:20 -0400
Received: from [62.206.217.67] ([62.206.217.67]:21731 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261549AbVDZOTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:19:15 -0400
Message-ID: <426E4DD2.8060808@trash.net>
Date: Tue, 26 Apr 2005 16:18:58 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ed Tomlinson <tomlins@cam.org>, Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
References: <200504240008.35435.kernel-stuff@comcast.net> <1114332119.916.1.camel@localhost.localdomain> <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net> <20050425153541.GC16828@wotan.suse.de> <426E3C6F.6010001@trash.net> <20050426135312.GI5098@wotan.suse.de> <426E48C0.9090503@trash.net>
In-Reply-To: <426E48C0.9090503@trash.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> Andi Kleen wrote:
> 
>> Hmm, thats hard to believe. And are you sure the NMI watchdog
>> did not trigger? (e.g. did you run it with serial or netconsole)?
> 
> I ran it with netconsole, but nothing was received. I'm going to retry
> with and without the patch once more to make sure.

I tried starting uml with and without the patch, five times each.
Without the patch it worked fine every time, with the patch it
instantly rebooted every time. Nothing was logged on netconsole.
Perhaps also interesting is that if I revert all patches after
this change up to HEAD, it doesn't always instantly reboot, but
sometimes just hangs. When using HEAD, it rebooted each time so far.

Regards
Patrick
