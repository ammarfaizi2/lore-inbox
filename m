Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSBXVGr>; Sun, 24 Feb 2002 16:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291301AbSBXVGi>; Sun, 24 Feb 2002 16:06:38 -0500
Received: from [195.63.194.11] ([195.63.194.11]:4371 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291306AbSBXVG1>;
	Sun, 24 Feb 2002 16:06:27 -0500
Message-ID: <3C7955AE.3070605@evision-ventures.com>
Date: Sun, 24 Feb 2002 22:05:50 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Arjan van de Ven <arjan@fenrus.demon.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
In-Reply-To: <200202241954.g1OJsPA32151@fenrus.demon.nl> <3C7946D9.1020908@evision-ventures.com> <20020224204513.A32303@fenrus.demon.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, Feb 24, 2002 at 09:02:33PM +0100, Martin Dalecki wrote:
> 
>>>it was about the i386 architecture, not just 80386 cpus. And yes 2.4 still
>>>runs on those; you'be surprised how many
>>>embedded systems run 80386 equivalents...
>>>
>>Interresting. But do they still incorporate ST509 and other
>>archaic controllers? Or do they have broken BIOS-es which don't
>>setup the geometry information properly? I don't think so.
>>
> 
> You bet that embedded systems use controllers that emulate archaic ones.
> Oh and bios.... well...... 
> 
> 
>>Well now I'm quite convinced. We can point those people to the legacy
>>single host driver anyway... And then the tradeoff goes just in favour
>>of supporting more and more common new hardware - it will just make
>>more people happy than it will make people loose :-).
>>
> 
> If you drop hardware support for no good reason.... you scare me. you
> really do. Now dropping hardware support (or moving support
> elsewhere) isn't always avoidable, but I'd think you need a pretty
> good reason to do so.

Yes right. But first please really really think again what ST509 and MFM
controllers are ;-). And after all I have already heard some time
before some real complains from real users around me about the
particular behaviour currently present, which tried to use software raid 
on ATA disks. And after all please have a look at the note from Andires 
inside the patch, which has been there for a long time now.

Hmm I will perhaps have just to check what distro-backed-kernels do
here... Becouse if my memmory is right, they are removing this 
particular function too already...

If you have any objections please *point me* at a particular system
where this would really break things.

