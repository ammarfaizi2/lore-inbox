Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269239AbUIHRxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269239AbUIHRxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 13:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbUIHRxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 13:53:40 -0400
Received: from mail.tmr.com ([216.238.38.203]:3597 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269239AbUIHRxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 13:53:32 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Scheduler experiences (with Reiser4 bug report)
Date: Wed, 08 Sep 2004 13:53:50 -0400
Organization: TMR Associates, Inc
Message-ID: <chngi1$tqc$1@gatekeeper.tmr.com>
References: <20040905142502.GQ26192@nysv.org> <20040905155502.GR26192@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1094665602 30540 192.168.12.100 (8 Sep 2004 17:46:42 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040905155502.GR26192@nysv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Törnqvist wrote:
> Yours truly wrote:
> 
>>I haven't tried nicksched in a while, but it didn't perform as well as
>>Staircase.
> 
> 
> Just gave -rc1-mm3 a shot and had my filesystems say bad things.
> shrike kernel: reiser4 panicked cowardly: assertion failed: extent_get_start(ext) == extent_get_start(&uf_coord->extension.extent.extent)
> /bin/sh: line 1:  4407 Segmentation fault      rm -f fs/xfs/.xfs_bmap.o.d
> 
> 
> Didn't get around to renicing X, but anyway, app launch time was longer
> and the music did twitch a bit when starting the simultaneous kernel
> and glibc compiles. So I'm still on Staircase and don't see any reason
> to change away.
> 
> I retried running as much cpu-intensive stuff as I could on cko5, basically
> ck6, and everything was smooth. Respects to Con for that :)
> 
> This is not a troll nor a flamebait, but an honest question.
> Should the need to re-nice X not be seen as broken behavior?

It would be desirable to have things run without doing that, people will 
undoubtedly call it a bug or tuning, depending on point of view.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
