Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTJ3LK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 06:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTJ3LK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 06:10:58 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:62693 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262369AbTJ3LK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 06:10:57 -0500
Message-ID: <3FA0F1B7.7000409@softhome.net>
Date: Thu, 30 Oct 2003 12:10:47 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trelane@digitasaru.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Things that Longhorn seems to be doing right
References: <LUlv.31e.5@gated-at.bofh.it> <M7iG.41B.7@gated-at.bofh.it> <MagC.82U.7@gated-at.bofh.it> <Maqe.8l3.9@gated-at.bofh.it>
In-Reply-To: <Maqe.8l3.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot wrote:
> From Theodore Ts'o on Wednesday, 29 October, 2003:
> 
>>Keep in mind that just because Windows does thing a certain way
>>doesn't mean we have to provide the same functionality in exactly the
>>same way.
>>Also keep in mind that Microsoft very deliberately blurs what they do
>>in their "kernel" versus what they provide via system libraries (i.e.,
>>API's provided via their DLL's, or shared libraries).
> 
> Indeed, although certain things could be half-kernel, half-user
>   (OK, 0.01% kernel, 99.99% user, e.g. userspace daemon that
>   intercepts certain writes).  Of course, at that point, you might
>   make a special library to interact with the daemon directly, although
>   it's then not at all like just calling write().
> 

   I beleive this is 100% user space issue.

   And I think if one really want to do something like this - Gnome's 
VFS is a good candidate for this. They already have all abstractions in 
place.

   [ Yes, sure I'm not using gnome by myself - but knowing nature of the 
prokect I bet they already started doing something like this ;-))) Ashes 
to ashes, dust to dust - bloat to bloat. ]

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

