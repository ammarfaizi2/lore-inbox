Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291020AbSBXUDb>; Sun, 24 Feb 2002 15:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291026AbSBXUDW>; Sun, 24 Feb 2002 15:03:22 -0500
Received: from [195.63.194.11] ([195.63.194.11]:29714 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291022AbSBXUDK>; Sun, 24 Feb 2002 15:03:10 -0500
Message-ID: <3C7946D9.1020908@evision-ventures.com>
Date: Sun, 24 Feb 2002 21:02:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: arjan@fenrus.demon.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
In-Reply-To: <200202241954.g1OJsPA32151@fenrus.demon.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@fenrus.demon.nl wrote:
> In article <3C79435E.8030208@evision-ventures.com> you wrote:
> 
> 
>>linux ide driver anyway. And I think that 2.4.x and above don't run on
>>i386's anymore anyway.
>>
> 
> it was about the i386 architecture, not just 80386 cpus. And yes 2.4 still
> runs on those; you'be surprised how many
> embedded systems run 80386 equivalents...

Interresting. But do they still incorporate ST509 and other
archaic controllers? Or do they have broken BIOS-es which don't
setup the geometry information properly? I don't think so.

Well now I'm quite convinced. We can point those people to the legacy
single host driver anyway... And then the tradeoff goes just in favour
of supporting more and more common new hardware - it will just make
more people happy than it will make people loose :-).


