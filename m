Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbVLFO7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbVLFO7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVLFO7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:59:19 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:21139 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751681AbVLFO7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:59:18 -0500
Message-ID: <4395A74C.1020706@tmr.com>
Date: Tue, 06 Dec 2005 09:59:24 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Ranson <david@unsolicited.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <4391E52D.6020702@unsolicited.net> <20051203222731.GC25722@merlin.emma.line.org> <43921DEC.9080406@unsolicited.net>
In-Reply-To: <43921DEC.9080406@unsolicited.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ranson wrote:
> Matthias Andree wrote:
> 
> 
>>So was I. And now what? ipfwadm and ipchains should have been removed
> 
>>from 2.6.0 if 2.6.0 was not to support these. That opportunity was
> 
>>missed, the removal wasn't made up for in 2.6.1, so the stuff has to
>>stick until 2.8.0.
>>
>>
> 
> I'm not aware of that policy... maybe I overlooked something?

Until 2.6, a stable series did not remove existing features, so someone
building an rpm or deb package could release it for "2.4.12 or later"
and expect it to work.

As a for instance there are people who went to 2.6 and kept their old
firwall rules written in ipchains, because they still worked. Now if
ipchains are deleted a full rewrite of firewall rules is needed, and
that just shouldn't be don't in haste. My personal opinion is that
ipfwadm and ipchains should have followed some other features into the
night before 2.6.0 ever came out. No one would have gotten a nasty
surprise later. I also think that reiser4 is 2.7 material, if there were
a 2.7.

I didn't see all that much wrong with the old odd/even model to tell the
truth, it wasn't perfect but you knew what you got.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

