Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbUD1Vaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUD1Vaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUD1Tuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:50:32 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:39381 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264943AbUD1Qkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:40:45 -0400
In-Reply-To: <1083161029.3788.92.camel@localhost.localdomain>
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com> <1083117450.2152.222.camel@bach> <1EF114FF-98C4-11D8-85DF-000A95BCAC26@linuxant.com> <1083161029.3788.92.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CA90E50C-9932-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Wed, 28 Apr 2004 12:40:43 -0400
To: Tom Sightler <ttsig@tuxyturvy.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 28, 2004, at 10:03 AM, Tom Sightler wrote:

> On Tue, 2004-04-27 at 23:28, Marc Boucher wrote:
>> We generally prefer to focus on making stuff work for users,
>> rather than waste time arguing about controversial GPL politics.
>
> Well, as one of your customers (I am a paid/licensed user of your
> Conexant modem drivers for my Dell D800) I am completely turned off by
> this.  I use a myriad of different binary drivers on various Linux
> systems, things like the NVidia binary driver, EMC PowerPath, VMware
> binary module, etc.  EMC PowerPath compares well to your example as it
> consist of multiple modules and each one spits out a message.  EMC
> simply used their documentation to tell the user that these messages
> means that the kernel can no longer be supported by the Linux 
> community,
> however, they can be safely ignored.

I'm sorry, but the typical user of EMC PowerPath cannot really be 
compared to the typical winmodem user.

If the issue hadn't been a real confusing / usability problem for 
thousands of individual customers, we wouldn't have bothered with the 
workaround.


>> I would like however to point out that part of the reason why people
>> sometimes resort to such kludges is that some kernel maintainers have
>> been rather reluctant to accommodate proprietary drivers which
>> unfortunately are a necessary real-world evil
>
> In my opinion your actions also represent a real-world evil.  As a user
> I'm reluctant to use proprietary drivers and certainly don't expect 
> the ones
> that I am forced to used to lie about that fact and try to pretend to 
> be GPL
> when they are not.

It is very common practice to simulate the perception of software to 
work around things and provide increased  comfort and compatibility. 
Entire GPL projects like wine, reactos, ndiswrapper (an open-source 
clone of our DriverLoader), and even the linux kernel itself implement 
foreign APIs or many workarounds to make programs or drivers function, 
even believe that they are running in another environment. Do these 
projects "lie" and represent real-world evils by technically pretending 
/ emulating results when they are in fact not the real thing?


>   After reading this I realized that I myself have probably
> reported kernel BUG's while your drivers were loaded, not realizing 
> that my
> kernel was really tainted because it didn't report that fact.  Who 
> knows how
> many other users may have done the same thing?

The problem goes both ways. Non-standard, unreported and hard to detect 
kernel patches have caused numerous users to report alleged driver bugs 
to us. You wouldn't know how much time and resources these things cost 
us.

> You seem to think that acceptance of Linux is somehow more important 
> that the
> GPL.  In my opinion it's exactly the opposite, acceptance and 
> recognition of
> the the importance of the GPL and the rights it gives you is more 
> important
> than the acceptance of Linux.

Some folks are more ideological than practical, but most people use 
Linux to solve practical needs.
The former are a lot more vocal than the silent majority.

>   If the "real-world" forces you to do something
> that gives up those rights (loading a binary module) the kernel should 
> definitely
> make the user aware.

The important part here is making the user aware, which we have clearly 
done.

Marc

>
> Later,
> Tom
>
>

