Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSG3JxD>; Tue, 30 Jul 2002 05:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSG3JxD>; Tue, 30 Jul 2002 05:53:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25871 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317253AbSG3JxD>; Tue, 30 Jul 2002 05:53:03 -0400
Message-ID: <3D4661A5.7030806@evision.ag>
Date: Tue, 30 Jul 2002 11:51:33 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.29 IDE 109
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>	 <3D45AAB4.1030409@evision.ag> <1028026788.6726.13.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Martin. The CS5530 one seems unneeded looking at the databook. Try the
> patch below instead, which removes the irq lock and uses the proper
> kernel functions to enable MWI and master.

Thanks for reaffirmation. This will be already in the upcomming 110.

> I'm not sure I like the fact you've deleted the ide-tape documentation.
> IDE tape is a pretty tricky thing, especially all the command handling
> weirdnesses. How about moving it into Changelog.idetape if you dont want
> it in the code itself ?

The interresting parts I have moved over to ide.txt in Documentation.
The "inner workings" part was:

a) ehm, very very terse in style.

b) not quite revealing the reality.

I decided that it would be better to have no docu then misguiding docu.
In esp. the description of DSC handling was not adequate.

The "history of the human race" kind of documentation was certainly
not worth it, becouse: kernel release -> bandwidth consumption ->
energy production -> environmental pollution -> not good for this
planet and not of much value for the developer reading it. I checked the 
contents in first place ;-). I tried to preserve credentials of course.


