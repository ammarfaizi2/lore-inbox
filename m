Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030576AbWCTWKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbWCTWKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWCTWJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:09:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:61919 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030562AbWCTWJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:09:37 -0500
X-Authenticated: #17142692
Message-ID: <441F281E.5060405@gmx.de>
Date: Mon, 20 Mar 2006 23:09:34 +0100
From: thomas schorpp <t.schorpp@gmx.de>
Reply-To: t.schorpp@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: de, en-us
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: "Ballentine, Casey" <crballentine@essvote.com>,
       video4linux-list@redhat.com, linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, v4l-dvb-maintainer@linuxtv.org,
       "'Mauro Carvalho Chehab'" <mchehab@infradead.org>,
       mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [linux-usb-devel] RE: [usb-storage] Re: [v4l-dvb-maintainer]
 2.6.16-rc: saa7134 + u sb-storage = freeze
References: <Pine.LNX.4.44L0.0603161039410.5253-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0603161039410.5253-100000@iolanthe.rowland.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Wed, 15 Mar 2006, Ballentine, Casey wrote:
> 
> 
>>Mauro,
>>
>>I would bet we could add the vt8235 to the list of broken chipsets 
>>as well, if it's not already there.  My company has completely 
>>disabled DMA in the 2.6.13.4 kernel we're running on an 
>>EPIA PD-10000 board due to lockupslike these.  We came across 
>>a thread on the via arena website while researching possible 
>>problems on the VIA boards:
>>
>>http://forums.viaarena.com/messageview.aspx?catid=28&threadid=60131&STARTPAG
>>E=1&FTVAR_FORUMVIEWTMP=Linear
> 
> 
> Here's another interesting link from VIA's site.  They claim to have fixed 
> the DMA problem (for some boards, anyway):
> 
> http://forums.viaarena.com/messageview.aspx?catid=28&threadid=67386&enterthread=y
> 
> Alan Stern
> 
> _______________________________________________
> Usb-storage mailing list
> Usb-storage@lists.one-eyed-alien.net
> https://lists.one-eyed-alien.net/mailman/listinfo/usb-storage
> 
> 

what DMA problem? ive always used via chipsets with usb. now the 8237. 

the via pci-busmaster dma hangs the system? try setting pci latency to 64.
most bioses initialize with 32. this had been a known problem, for me too.
this has been left out of the discussion at via forums.

and what knows a usb controller about MPEG? thats another layer.

so a bios fixes this and other os have no problem with this, 
so its fixable by software. then do it now, pls.

and stop this "blacklisting habit", all these nowadays chips are designed-to-cost 
"consumer crap" somewhow.
or do you want linux-usb to be blacklisted as "broken" by the manufacturers blacklists? ;)


y
tom

