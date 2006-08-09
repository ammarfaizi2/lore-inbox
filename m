Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWHINpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWHINpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWHINpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:45:35 -0400
Received: from wasp.net.au ([203.190.192.17]:8901 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1750815AbWHINpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:45:34 -0400
Message-ID: <44D9E6EF.9050400@wasp.net.au>
Date: Wed, 09 Aug 2006 17:45:19 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-pm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net,
       ncunningham@linuxmail.org
Subject: Re: [Suspend2-devel] Re: swsusp and suspend2 like to overheat my
 laptop
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>	<20060808235352.GA4751@elf.ucw.cz>	<Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>	<20060809073958.GK4886@elf.ucw.cz>	<Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>	<20060809115843.GB3747@elf.ucw.cz> <Pine.LNX.4.58.0608090932460.3785@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0608090932460.3785@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
> Well it went to sleep fine.  But when I tried to wake it up again, the
> screen didn't come back. I'm not sure if the keyboard was working either.
> But I could eject the CD and when I put it back in, it seemed to mount it.
> 

Different laptop of course.. but good results can often be had with
s2ram -f -s

Running the full array of command line permutations can be somewhat tedious though. A good initramfs 
and separate grub boot entry help there a great deal (no fsck if you lock it up).

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
