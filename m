Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUEVOIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUEVOIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUEVOIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:08:48 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:2181 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261378AbUEVOIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:08:46 -0400
Message-ID: <40AF5F75.7000206@tmr.com>
Date: Sat, 22 May 2004 10:11:01 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge preparation: Rationale behind the freezer changes.
References: <40A8606D.1000700@linuxmail.org> <20040521093307.GB15874@elf.ucw.cz> <40ADF605.2040809@linuxmail.org> <200405211542.40587.oliver@neukum.org> <40AE837E.4030708@linuxmail.org>
In-Reply-To: <40AE837E.4030708@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> Oliver Neukum wrote:
> 
>> Am Freitag, 21. Mai 2004 14:28 schrieb Nigel Cunningham:
>>
>>> Yes, but what order? I played with that problem for ages. Perhaps I 
>>> just  didn't find the right combination.
>>
>> How about recording the order of creation and do it in opposite order?
> 
> 
> We could add a field to the process struct to record that. (Since PIDs 
> can wrap, they can't be relied upon for this).

I would never suggest keeping a process creation date for something 
trivial, but since you seem to be proposing one for something major, the 
process creation date could be available in the readdir of the /proc 
directory. Assuming you intend to keep date at all and not just some 
counter, of course.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
