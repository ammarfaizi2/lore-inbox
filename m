Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUH1DEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUH1DEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 23:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUH1DEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 23:04:15 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:61645
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S266236AbUH1DEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 23:04:07 -0400
Message-ID: <412FF60B.5080009@winischhofer.net>
Date: Sat, 28 Aug 2004 05:03:39 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, nemosoft@smcc.demon.nl
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
References: <412F4008.4050700@winischhofer.net> <20040827130151.46c246b0.davem@redhat.com>
In-Reply-To: <20040827130151.46c246b0.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Fri, 27 Aug 2004 16:07:04 +0200
> Thomas Winischhofer <thomas@winischhofer.net> wrote:
> 
> 
>>OK and if the authors of, say, SMP support say "back it out", Linux ends 
>>up without SMP support. Cool.
> 
> 
> If you could get each and every author of SMP support to agree,
> sure.  But good luck getting that is quite a large group of
> folks and since Linus is one of those authors.
> 
> And last I checked, no binary-only module hooks were added to
> the SMP support recently, so nothing for them to get upset
> about. :-)

For crying out loud - that was an example. Forget the hook and forget 
the binary part of the pwc driver.

s/SMP support/RTL8139 driver/g

Get the point?

A license is a license. We can't just obey a single driver's author's 
daily mood. (And for those who don't know: IAAL. Fact.)

I understand that Nemosoft got mad... what GKH did was a little like 
calling you an a**hole with a smile on your face. No offense towards 
Greg, he does a brillant job. Nemosoft will calm down (if his pride 
permits and we don't make him look like he's losing his face - so shut up).

Don't behave like children, please.

You have no idea how often I god mad over a maintainer's opinion. No 
names now. Did I ever revoke the sisfb or my XFree86/X.org driver license?

Short version: I just think Greg and Linus are too nice in this very 
case. Keeping the open source part of pwc in the kernel is - based on 
the fact that the driver has been committed under the GPL - a matter 
that shouldn't be subject to discussions at all, of that kind and 
especially that wording. Hook or no hook. Once again, forget the hook 
and forget the binary part.

If we can agree on the driver without the hook, fine.

(Let the flamewar begin: The binary pwcx is 0x3000 bytes of asm code. No 
FPU stuff, just data tables. The 3 algos in question are pretty 
primitive. Ridiculous. If there is anybody who really wants it, we'll 
have an open souce C version within a week. People now thinking that I 
ignore the SCO case please write to me privately. I am ready to explain 
the difference between patent and copyright law and the world's general 
legal opinion on reverse-engineering. And even it's the 1013481791873th 
time. But don't be surprised if you get a form letter.)

Suggestion to Nemosoft (I hope your mail address still works): What 
about the following model:

1) We have an open source driver (without decompression) in the mainline 
kernel (which you maintain).

2) You provide a binary-only module which entirely replaces the mainline 
module? This way you don't need the hook. Just put everything in a 
single module that, by a patch and a binary, replaces the entire 
mainline version.

Extra maintainance effort: Zero.

Besides: If your NDA really expired a year ago, what's the point? 
(Please send me the NDA privately. I can give you a reliable legal opinion.)

Kids, please. How old are you? Please keep our common goal in mind.

Cheers.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
