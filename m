Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTEGAKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTEGAKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:10:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:60103 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262060AbTEGAKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:10:07 -0400
Message-ID: <3EB851B3.6050804@gmx.net>
Date: Wed, 07 May 2003 02:22:11 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
References: <Pine.LNX.3.96.1030506142904.9452D-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030506142904.9452D-100000@gatekeeper.tmr.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On Mon, 5 May 2003, Chris Friesen wrote:
> 
> 
>>Felix von Leitner wrote:
>>
>>>Thus spake David S. Miller (davem@redhat.com):
>>
>>>>Either reproduce without the nvidia module loaded, or take
>>>>your report to nvidia.
>>>
>>>Thank you for this stunning display of unprofessionalism and zealotry.
>>>People like you keep free software alive.
>>
>>He may not have put it as politely as you would like, but there really is no way 
>>to debug a problem in a kernel which has been tainted by binary-only drivers. 
>>That driver could have done literally anything to the kernel on loading.
> 
> There's no need to be rude in any case, particularly after the OP reposted
> a not tainted oops which had been through ksymoops and didn't get any help
> anyway. Why be nasty about the format of a question you're not answering
> even after it's been asked again in the preferred format?

Because the OP violated the lkml FAQ section 1.18:
All problems discovered whilst such a module is loaded must be reported
to the vendor of that module, /not/ the Linux kernel hackers and the
linux-kernel mailing list. [...] "oops" reports marked as tainted are of
no use to the kernel developers and will be ignored.

Davem just restated this fact with the same admittedly strong wording.
Felix von Leitner accused him of unprofessionalism and zealotry. That is
what I would call an offence.

> It's a shame that some people seem to think that lots of hard work
> entitles them to be rude and condescending, while really important
> contributors like Alan Cox, Ingo and akpm can be polite and helpful, even
> when they are correcting someone or disagreeing on an approach to a
> problem.

It's even more shocking if a user insults a kernel developer and expects
this developer (or one of his peers) to actually take care of the
problem. wli chose to investigate the report anyway, something not to be
taken for granted.

Hey, if I insulted Al Viro I'd never expect him to help me (respond,
point out mistakes etc.) anymore. Besides that, Al saved me from diving
into floppy.c, for which I'm still thankful.

Chris: Just a heads up - you may get private hate mail from Peter
"Firefly" Lund like I did because you pointed out a mistake of the OP.
So be warned about it.


Carl-Daniel

