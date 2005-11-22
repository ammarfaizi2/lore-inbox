Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVKVUI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVKVUI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVKVUIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:08:55 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:35846 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S965139AbVKVUIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:08:55 -0500
Message-ID: <43837AD1.7060504@argo.co.il>
Date: Tue, 22 Nov 2005 22:08:49 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: jgarzik@pobox.com, jonsmirl@gmail.com, benh@kernel.crashing.org,
       alan@lxorguk.ukuu.org.uk, airlied@gmail.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com>	<20051121230136.GB19212@kroah.com>	<1132616132.26560.62.camel@gaston>	<21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>	<1132623268.20233.14.camel@localhost.localdomain>	<1132626478.26560.104.camel@gaston>	<9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>	<43833D61.9050400@argo.co.il>	<20051122155143.GA30880@havoc.gtf.org>	<43834400.3040506@argo.co.il>	<20051122172650.72f454de.diegocg@gmail.com>	<438348BB.1050504@argo.co.il> <20051122204910.a4bd1d1e.diegocg@gmail.com>
In-Reply-To: <20051122204910.a4bd1d1e.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Nov 2005 20:08:52.0915 (UTC) FILETIME=[8F5FC030:01C5EFA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:

>El Tue, 22 Nov 2005 18:35:07 +0200,
>Avi Kivity <avi@argo.co.il> escribió:
>  
>
>>I don't have a Windows box, but I'm quite sure Windows (without the more 
>>esoteric switches) is quite stable, even in SMP. The '95 and NT 4.0 days 
>>are gone. Give the drivers the environment they like (mangle the 
>>addresses if necessary, single thread them, allow them larger stacks, 
>>whatever it takes) and they will work well. Put them in userspace if 
>>you're paranoid or isolate them using binary translation.
>>    
>>
>
>You seem to miss my point: In a typical windows installation, some
>drivers are CRAPPY. It's not about the windows "core". It's the thousand
>of crappy drivers made by crappy companies to support cheap devices
>which makes it unstable.
>
>  
>
None of the desktop Windows installations I'm aware of exhibit this. The 
recent versions of Windows are fairly stable.

>The /3GB makes windows to switch to 1GB/3GB mode instead of the default
>2GB/2GB. Passing "/PAE /3GB" options to the windows kernel is used by
>many people to measure the quality of the drivers - and _many_ times
>(specially with cheap hardware) it doesn't work. Some times the box
>won't even boot.
>  
>
Nobody uses this option (well my father does, but he's in technical 
computing. I was unable to convince him to move to Linux).

Most people have stable, easy to use Windows desktops. I don't like to 
admit it, but I had to fight to get my via video to work correctly.

>The same goes for SMP. Windows is SMP safe, but I bet my ass
>that the big majority of drivers made for cheap devices has not
>been tested in a smp box - I've seen it myself, my dual p3 box
>dies as soon as the dialup app tells the drivers of a cheap 
>winmodem I have to do its job.
>  
>
(The Linux driver does not fail, though)

>Which, by the way, is going to be _really_ fun in the windows
>world now that people is buying dual-core machines. Thousand of
>SMP-unsafe code paths will soon start being tested by millions
>of customers buying dual-core CPUs...(and is not that all linux
>drivers are or will be better but having the source allows fixing
>them...)
>
>  
>
Many people have hyperthreaded CPUs today.

>> From this discussion, it looks like the choices of the future are 
>>Windows drivers or serial terminals. Excuse me now while I look for my 
>>null-modem cable.
>>    
>>
>
>You seem to forget linux history: Linux started having _zero_ zupport
>for hardware except for a few devices and a single 32 bit architecture.
>Right now its the operative system with the biggest number of drivers
>on the world (most of windows drivers are not made by microsoft). 
>
I sincerly doubt Linux ships with more drivers than Windows. And when 
you compare driver availability (shipped or vendor provided) the gap is 
very wide.

>Linux
>has beated companies like nvidia and ati in this field many times and
>can do it again.
>  
>
It works well on the server, where Linux has a large and rising market 
share. It doesn't work on the home desktop where Linux is nonexistent. 
There are also intellectual propery issues involved in video which 
prevent open drivers.

So, your Winmodem, most people's 3D cards, many wireless adapters, and 
all the esoteric devices are not supported (it is nice to see the 
situation improving with wireless, though). The lack of drivers is one 
of the blocks towards expansion on the home desktop, and vice versa.

Perhaps Windows drivers can allow enlarging the desktop market share, 
after which they will not be needed because the vendors will see the 
light and provide open, and presumably better drivers.



-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

