Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264288AbUENFeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUENFeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUENFeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:34:03 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:199 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264288AbUENFd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:33:57 -0400
To: Valdis.Kletnieks@vt.edu
Cc: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilites, take 2
References: <200405131308.40477.luto@myrealbox.com>
	<20040513182010.L21045@build.pdx.osdl.net>
	<200405140135.i4E1Zp7A025139@turing-police.cc.vt.edu>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 14 May 2004 07:33:32 +0200
In-Reply-To: <200405140135.i4E1Zp7A025139@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Thu, 13 May 2004 21:35:51 -0400")
Message-ID: <874qqj1sk3.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Thu, 13 May 2004 18:20:10 PDT, Chris Wright said:
>
>> I think it still needs more work.  Default behavoiur is changed, like
>> Inheritble is full rather than clear, setpcap is enabled, etc.  Also,
>> why do you change from Posix the way exec() updates capabilities?  Sure,
>> there is no filesystem bits present, so this changes the calculation,
>> but I'm not convinced it's as secure this way.  At least with newcaps=0.
>
> The last time the "capabilities" thread reared its head a while ago, Andy made
> a posting that pretty conclusively showed that the Posix way was totally b0rken
> if you ever intended to support filesystem bits.  So if you wanted to ever have
> a snowball's chance of supporting something like:
>
> chcap cap_net_raw+ep /bin/ping

Seems like you're not aware of:
<http://www.olafdietsche.de/linux/capability/>

This supports filesystem capabilities with the current (POSIX?)
implementation. So, whatever Andy has shown, it has at least one
counter evidence q.e.d.

> 2) Toss all the filesystems capabilities support out the window.

I agree to disagree ;-)

Regards, Olaf.
