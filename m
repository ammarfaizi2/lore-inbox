Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUCWRM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUCWRM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:12:26 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:38287 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262698AbUCWRMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:12:24 -0500
Message-ID: <406070F9.2070900@tmr.com>
Date: Tue, 23 Mar 2004 12:16:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
References: <1CD8E-65d-33@gated-at.bofh.it> <1CFMG-8wf-61@gated-at.bofh.it> <1CGft-ry-3@gated-at.bofh.it>
In-Reply-To: <1CGft-ry-3@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García wrote:
> El Mon, 22 Mar 2004 22:57:09 +0100 Adrian Bunk <bunk@fs.tum.de> escribió:
> 
> 
>>OSS will stay in 2.6 (2.6 is a stable kernel series) but it will most
>>likely be removed in 2.7.
> 
> 
> Personally, as an user, I'd like to have the OSS drivers which don't have
> a ALSA equivalent for my old hardware. There're several
> sound cards with both ALSA and OSS drivers where ALSA works
> much better 99% of the time. Those could be safely removed
> (even in the 2.6 timeframe, I'd argue) but I'd like to keep the ones
> without an alsa equivalent for my old hardware (specially now that we
> have a -tiny tree ;) however I can understand that if they don't
> have a maintainer they'll get removed...

The real issue with removing OSS from a stable kernel is that a kernel 
update should not break existing system software (at least compliant 
software). As of early 2.6 it seemed that you had to update to the ALSA 
mixer and {something I don't remember} if you used the OSS emulation. I 
just used OSS and it worked. Based on only two systems, so it may not apply.

Stable and install new sound software don't seem to mix well. I suggest 
that the current course is a good one, keep both systems in the stable 
kernel.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
