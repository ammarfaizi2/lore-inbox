Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312484AbSC3NY3>; Sat, 30 Mar 2002 08:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312485AbSC3NYT>; Sat, 30 Mar 2002 08:24:19 -0500
Received: from duneyr.obbit.se ([194.165.245.23]:15748 "EHLO mail.obbit.se")
	by vger.kernel.org with ESMTP id <S312484AbSC3NYM>;
	Sat, 30 Mar 2002 08:24:12 -0500
Message-ID: <3CA5BBF9.4010606@2gen.com>
Date: Sat, 30 Mar 2002 14:22:01 +0100
From: =?ISO-8859-15?Q?David_H=E4rdeman?= <david@2gen.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.9+) Gecko/20020325
X-Accept-Language: en,sv
MIME-Version: 1.0
To: LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load togeter
In-Reply-To: <200203300212.02322.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got some mails regarding my first mail and I'll try to respond to the 
feedback...

Mark Hahn wrote:
 >>newly bought Adaptec 2400A IDE-Raid card sucked so badly
 >>in combination with my VIA KT133 based board.
 >
 >
 > that's a bizarre combination: quite old/cheap motherboard with a
 > fairly expensive HW raid card.
 >

Yes, but that was the box that was available for testing currently. 
Thats life :-)

 > of course, you could do everyone a big favor by finding a tool that
 > would dump the chipset's PCI config space under windows, to see what
 > the patch changes.  under Linux, of course, lspci does this.

Yes, I could do that (using WPCREDIT), but I'd like to know that it 
would be helpful to some kernel hackers first, so mail me and I'll do it.

If someone *is* interested, I'll dump bus0,dev0,func0 (Host Bridge) and 
bus0,dev1,func0 (PCI-PCI bridge) with and without patches installed, is 
there any other device that should be included (like IDE-controller)?



Dieter Nützel wrote:
 > Can you please redo with latest VIA fix applied?

I did try with the latest VIA patch applied (it gave approx 4Mb/s in 
increase). However, some more research has uncovered yet more hardware 
issues that may (in combination with the VIA issues) be the "real" 
perpetrator.

Apparently (by looking at the links at the end of this mail), SeaGate 
Barracuda IV's and RAID is a big mistake. I will RMA the drives and buy 
some other brand before I continue benchmarking the 2400A card.

Thanks to Mark, Dieter and Ville.

Regards,
David

Barracuda IV problem links
==========================
http://forums.storagereview.com/viewtopic.php?t=2154
http://forums.storagereview.net/viewtopic.php?t=430
http://forums.storagereview.net/viewtopic.php?t=85
http://www.viahardware.com/faq/kt7/faqhpt370.htm#barracuda
http://www.baluma.com/hardware/almacenamiento/barracudaIV/home.asp
http://www.msi.com.tw/forum/index.php?target=article&tid=6899&page=2
http://www.geocities.com/teomorell/st380021a/winbench.htm
http://forums.storagereview.net/viewtopic.php?t=1333


