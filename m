Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVAYTQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVAYTQC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVAYTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:16:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:21160 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262065AbVAYTPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:15:12 -0500
Message-ID: <41F68FB0.7080808@osdl.org>
Date: Tue, 25 Jan 2005 10:28:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@dsv.su.se>
CC: Bryce Harrington <bryce@osdl.org>, Chris Wright <chrisw@osdl.org>,
       dev@osdl.org, linux-kernel@vger.kernel.org,
       stp-devel@lists.sourceforge.net
Subject: Re: Kernel 2.6.11-rc1/2 goes Postal on LTP
References: <Pine.LNX.4.33.0501221125140.30167-100000@osdlab.pdx.osdl.net>	 <41F46B32.9070904@osdl.org> <1106680321.705.52.camel@boxen>
In-Reply-To: <1106680321.705.52.camel@boxen>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:
>>Similar for me, easy to reproduce (3 times today).
>>Here's a kernel messages log, with 32 processes killed,
>>mostly hotplug, but also bash (2x), runltp, & some daemons.
>>
>>I could not login and do anything else, but I could/did
>>SysRq-T, P, M, S, U, B to reboot.  These are also in the log.
>>
>>log:
>>http://developer.osdl.org/rddunlap/oom/oom_kill.txt
>>
>>config:
>>http://developer.osdl.org/rddunlap/oom/config-2611rc2
>>
>>on P4-UP, 1 GB RAM.
>>
> 
> 
> I saw this aswell. Appears to be the pipe leak cause it doesn't go nuts
> with the patch at the bottom from Linus.

I expected that as well, but I haven't rerun it to confirm.

I'm going on the the nptl test next....

Thanks,
-- 
~Randy
