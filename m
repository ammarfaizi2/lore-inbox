Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTIFUWL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 16:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTIFUWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 16:22:10 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.92.226.153]:49877 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261695AbTIFUWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 16:22:07 -0400
Message-ID: <3F5A427E.1060300@maine.rr.com>
Date: Sat, 06 Sep 2003 16:24:30 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mehmet Ceyran <mceyran@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
References: <003901c373c3$e02f5080$0100a8c0@server1>
In-Reply-To: <003901c373c3$e02f5080$0100a8c0@server1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mehmet Ceyran wrote:
>>>Error-checkers like Lint, that use a specific langage such 
>>>as 'C', can provide the programmer with a false sense of
>>>security. You  end up with 'perfect' code with all the
>>>unwanted return-values cast to "void", but the logic remains
>>>wrong and will fail once the high-bit in an integer is set.
>>>So, in some sense, writing procedures in assembly is
>>>"safer". You know what the code will do before you run it.
>>>If you don't, stay away from assembly.
>>
>>This is part of what makes someone a 'real' programmer, in my opinion.
>>In my experience, 'Unreal' programmers tend to excessively 
>>re-use code from other applications they've written, and just 
>>hack it about until it works, at times leaving in code for 
>>features that are never used in the new context :-).
> 
> 
> Code re-usage is not a bad thing in computer science because it can save
> you much work. But it has to be done correctly. Best thing is to use
> so-called "design patterns": Solutions to common problems that have been
> proven to work in many different environments. So if you solved some
> problem in your past programs (of course specifying it well before) and
> you prove that it doesn't work only for that particular program, then
> there's no need to reinvent the wheel. For example that's why you use
> standard libraries for basic operations like output to console.
> 
> You're right in the part that one should not have to hack the re-used
> code until it works because that leads to dirty coding.
> 
> I'd also like to mention that algorithms implemented in high-level
> languages can be mathematically proven too, for example with the hoare
> calculus, which provides basic axioms for handling of sequences, loops
> and conditional statements.
> 
> 	Mehmet
> 
> -

Mathematical proof only within the static non executing realm.  Add in 
the rest of the executing environment and you are out of luck. A 
correctly written logically correct program is _not_ garunteed to 
produce correct results.

Cheers,
   Dave

