Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVECTz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVECTz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVECTzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:55:54 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:10894 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261652AbVECTz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:55:29 -0400
Message-ID: <4277B778.5020206@tmr.com>
Date: Tue, 03 May 2005 13:40:08 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Andrea Arcangeli <andrea@suse.de>, Matt Mackall <mpm@selenic.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark 
References: <20050430025211.GP17379@opteron.random> <200505021614.j42GEufG008441@turing-police.cc.vt.edu>
In-Reply-To: <200505021614.j42GEufG008441@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 02 May 2005 11:49:32 EDT, Bill Davidsen said:
> 
>>Andrea Arcangeli wrote:
>>
>>>On Fri, Apr 29, 2005 at 01:39:59PM -0700, Matt Mackall wrote:
> 
> 
>>>-#!/usr/bin/python
>>>+#!/usr/bin/env python
>>> #
>>> # mercurial - a minimal scalable distributed SCM
>>> # v0.4b "oedipa maas"
>>
>>Could you explain why this is necessary or desirable? I looked at what 
>>env does, and I am missing the point of duplicating bash normal 
>>behaviour regarding definition of per-process environment entries.
> 
> 
> Most likely, his python lives elsewhere than /usr/bin, and the 'env' call
> results in causing a walk across $PATH to find it....

Assuming that he has env in a standard place... I hope this isn't going 
to start some rash of efforts to make packages run on non-standard 
toolchains, which add requirements for one tool to get around 
misplacement of another.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

