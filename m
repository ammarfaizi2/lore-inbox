Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267889AbUHKCsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267889AbUHKCsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267888AbUHKCsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:48:08 -0400
Received: from gizmo06bw.bigpond.com ([144.140.70.41]:10905 "HELO
	gizmo06bw.bigpond.com") by vger.kernel.org with SMTP
	id S267890AbUHKCsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:48:02 -0400
Message-ID: <411988DF.9010308@bigpond.net.au>
Date: Wed, 11 Aug 2004 12:47:59 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spaminos-ker@yahoo.com
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
 others)
References: <20040811010116.GL11200@holomorphy.com> <20040811022143.4892.qmail@web13910.mail.yahoo.com> <20040811022345.GN11200@holomorphy.com> <41198859.7050807@bigpond.net.au>
In-Reply-To: <41198859.7050807@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> William Lee Irwin III wrote:
> 
>> On Tue, Aug 10, 2004 at 07:21:43PM -0700, spaminos-ker@yahoo.com wrote:
>>
>>> I am not very familiar with all the parameters, so I just kept the 
>>> defaults
>>> Anything else I could try?
>>> Nicolas
>>
>>
>>
>> No. It appeared that the SPA bits had sufficient fairness in them to
>> pass this test but apparently not quite enough.
>>
> 
> The interactive bonus may interfere with fairness (the throughput bonus 
> should actually help it for tasks with equal nice) so you could try 
> setting max_ia_bonus to zero (and possibly increasing max_tpt_bonus). 
> With "eb" mode this should still give good interactive response but 
> expect interactive response to suffer a little in "pb" mode however 
> renicing the X server to a negative value should help.

I should also have mentioned that fiddling with the promotion interval 
may help.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

