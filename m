Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVK2OqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVK2OqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVK2OqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:46:05 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:60028 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751369AbVK2OqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:46:02 -0500
Message-ID: <438B616B.6070101@tmr.com>
Date: Mon, 28 Nov 2005 14:58:35 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org> <20051123234256.GA27337@nevyn.them.org>
In-Reply-To: <20051123234256.GA27337@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> On Wed, Nov 23, 2005 at 03:08:59PM -0800, Linus Torvalds wrote:

>>In contrast, the simple silicon support scales wonderfully well. Suddenly 
>>libraries can be thread-safe _and_ efficient on UP too. You get to eat 
>>your cake and have it too.
> 
> 
> By buying new hardware and only caring about people using the magic
> architecture.  No thanks.

That is the problem, waiting for Intel to do hardware magic, or even to 
decide IF they do it. Like assuming that everyone has SMP because a few 
percent of the users have dual core chips. The majority of the markey 
will have SMP someday, but ignoring the current status isn't realistic.
> 
> Maybe I'll implement this some weekend.

Love to see it, I'm only semi-convinced it can be done in a way which 
actually produces significant benefits.
> 

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

