Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUHYUlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUHYUlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268602AbUHYUjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:39:04 -0400
Received: from mail.tmr.com ([216.238.38.203]:8198 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268590AbUHYUf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:35:56 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.9-rc1
Date: Wed, 25 Aug 2004 16:36:28 -0400
Organization: TMR Associates, Inc
Message-ID: <cgisra$2oe$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <805tv1-ec2.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1093465771 2830 192.168.12.100 (25 Aug 2004 20:29:31 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <805tv1-ec2.ln1@tux.abusar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dâniel Fraga wrote:
> In article <412BD946.1080908@linux-user.net>,
> 	Daniel Andersen <anddan@linux-user.net> writes:
> 
> 
>>As Linus initially said, there is the possibility of releasing a bug-fix 
>>patch 2.6.8.2 *after* 2.6.9 has been released. This can make things very 
> 
> 
> 	Why does this could happen? Do you agree with me that when 2.6.9 is
> released, all future versions should be based on 2.6.9? Or it's a BK
> issue I don't know?
> 
> 
>>confusing when patch-2.6.9 is against 2.6.8.1 and not 2.6.8.2 (or 
>>2.6.8). So if we use a rule of always patching against the first x.y.Z 
>>release (and not the last x.y.z.W by the time the new x.y.Z is released) 
>>we can assure consistence in the patch management.
> 
> 
> 	Ok, I understand the problem. But isn't it possible to avoid
> releasing some 2.6.8.x version after 2.6.9? I mean, I'm not
> understanding why this could happen.
> 
> 	Ps: sorry if this question is silly, but I didn't get the point why
> 2.6.8.2 could be released after 2.6.9.
> 
Say an evil bug is discovered in 2.6.8.1 about the time people find out 
that cdrecord and vmware don't run on 2.6.9 and Oracle causes a massive 
memory leak. Since the developers seem to totally disregard pre-release 
testing with any 3rd party or closed source software, this isn't totally 
out of the question.

So out comes 2.6.8.2 to protect the honor and virtue of all the users 
who run 3rd party software for some silly reason like needing it to make 
a living.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
