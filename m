Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUHYALp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUHYALp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268795AbUHYALp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:11:45 -0400
Received: from mail.broadpark.no ([217.13.4.2]:39907 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267535AbUHYAL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:11:26 -0400
Message-ID: <412BD946.1080908@linux-user.net>
Date: Wed, 25 Aug 2004 02:11:50 +0200
From: Daniel Andersen <anddan@linux-user.net>
User-Agent: Mozilla Thunderbird 0.7.2 (X11/20040712)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fraga@abusar.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>    <20040824184245.GE5414@waste.org>    <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org> <cggjvs$bv9$1@sea.gmane.org>
In-Reply-To: <cggjvs$bv9$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dâniel Fraga wrote:
> In article <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>,
> 	Linus Torvalds <torvalds@osdl.org> writes:
> 
> 
>>Any reason for your preference? 
> 
> 
> 	Linus, sorry but I can't agree with your decision.
>     
>     I'm not a developer, just an user and for me at least, there's no
> sense in supplying a patch related do 2.6.8 instead of 2.6.8.1.
> 
> 	I always update my kernel when the official patch is announced and
> I'd expect to follow a well defined order (2.6.8 -> 2.6.8.1 ->
> 2.6.9...).
> 
> 	Suppose we had 2.6.8.1, 2.6.8.2, 2.6.8.3 until 2.6.8.10. Should I
> remove 10 patches just to update to 2.6.9? For me it's a waste of time.
> 
> 	I know you kernel developers use BK or some other method, but...
> 
> 	Thanks.
> 

As Linus initially said, there is the possibility of releasing a bug-fix 
patch 2.6.8.2 *after* 2.6.9 has been released. This can make things very 
confusing when patch-2.6.9 is against 2.6.8.1 and not 2.6.8.2 (or 
2.6.8). So if we use a rule of always patching against the first x.y.Z 
release (and not the last x.y.z.W by the time the new x.y.Z is released) 
we can assure consistence in the patch management.

Daniel Andersen
--
