Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264106AbUD3Pzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbUD3Pzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 11:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUD3Pzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 11:55:31 -0400
Received: from pop.gmx.de ([213.165.64.20]:9893 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264106AbUD3Pz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:55:27 -0400
X-Authenticated: #21910825
Message-ID: <409276D6.9070500@gmx.net>
Date: Fri, 30 Apr 2004 17:55:02 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Giuliano Colla <copeca@copeca.dsnet.it>
CC: Linus Torvalds <torvalds@osdl.org>, hsflinux@lists.mbsi.ca,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it> <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org> <409256A4.5080607@copeca.dsnet.it>
In-Reply-To: <409256A4.5080607@copeca.dsnet.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Colla wrote:
> Linus Torvalds ha scritto:
> 
>> On Thu, 29 Apr 2004, Giuliano Colla wrote:
>>  
>>> Let's try not to be ridiculous, please.
>>
>> It's not abotu being ridiculous. It's about honoring peoples copyrights.
> 
> On that ground you're correct.
> [...]
> But please do consider a different perspective.
> 
> I'm an end user.
> I download a damn Linuxant driver because the manufacturer of the laptop
> I own has seen fit to use a Conexant chipset.
> In order to do that I must:
> a) Pay a (small) sum.
> b) Accept a Microsoft-like license agreement.
> If at that point I haven't realized that I'm not getting a fully GPL'd
> software I'm really terminally stupid as you kindly suggest.

If you look at the price of a cardbus real modem on ebay, you might be
surprised that these things are really cheap. Sometimes buying software to
support the winmodems is actually more expensive than buying a real modem.


> However, if I'm not terminally stupid, I will never think of addressing
> to kernel people in order to fix problems arising from or after loading
> the driver, and associated utilities, even if lsmod doesn't show
> "tainted" modules. Kernel people shouldn't even consider supporting the
> resulting mess.

How would you know NOT to complain to linux-kernel if there is no sign you
shouldn't?


> That said, I'd like to explain what made me react to the announcement
> posted.
> 
> Linuxant have figured a Microsoft-like brute force hardware detection
> mechanism: they attempt to load *all* drivers, and only the one which
> [...]
> But I didn't appreciate that the reaction to that mess has been also on
> Microsoft style.
> The reaction has been:
> 
> a) a workaround of the workaround (if you put a \0, I'll detect the
> Linuxant string)

Was there anything else that could have been done for the existing fake
GPL modules?


> b) a lie (the /GPL directory is empty).

I have this FUCKING Linuxant .rpm with an empty GPL directory right on my
hard disk. And this .rpm is signed by Linuxant. So either Linuxant has
been hacked (someone stole the key, signed a bogus rpm and broke into thir
site uploading it) or they are careless (forgetting to fill the GPL
directory for some packages). In both cases I would not trust them.


Carl-Daniel
