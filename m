Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312988AbSC0KGh>; Wed, 27 Mar 2002 05:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312989AbSC0KG1>; Wed, 27 Mar 2002 05:06:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:11999 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S312988AbSC0KGM>;
	Wed, 27 Mar 2002 05:06:12 -0500
Message-ID: <3CA197B9.2070502@yahoo.com>
Date: Wed, 27 Mar 2002 12:58:17 +0300
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: a.d.opmeer@student.utwente.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: Anyone else seen VM related oops on 2.4.18?
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Arjan Opmeer wrote:
> Are there other people that are suffering from a VM related oops on kernel 
> 2.4.18?
Yes:(
I've seen that oops 24/7 after installing a
new video card Radeon 7500 AGP.
Before I had PCI video card.
When DRI is enabled, the whole box hangs after
~10 minutes of using OpenGL, and if DRI disabled
and radeon.o is unloaded, I have a vm-related Oopses.
Exactly the same: invalid operand in __free_pages_ok().
I still have a lot of them in my system log, but I am
afraid I don't have the relevant System.map for
ksymoops'ing them.
I tried to switch to -ac tree and what I get is just
about the same Oops:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0203.3/0308.html

BUT: Andrea vm patches seems to cure that!
I am only two days with them, so everything is
still possible, but before it used to Oops just
about every half an hour.
So thousands of thanks goes to Andrea:)

Btw, I've seen exactly the same reports in DRI
mailing lists and they were reported with different video 
cards, but the similar thing was that all the reporters
has an AMD 751 Irongate as host bridge.
I also have it.
What is your north bridge?
This really seems strange for me that video card
or the host bridge causes vm to oops, but who knows...
Anyway, it is definitely not a nvidia drivers related:(

If anyone wants me to reproduce and ksymoops this
Oops, feel free to ask. I am ready to do just
about everything to get this problem fixed, else
I just can't use my new cool Radeon...
