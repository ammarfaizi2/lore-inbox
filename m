Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVCGVZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVCGVZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVCGVYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:24:30 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:27576 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261829AbVCGUQQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:16:16 -0500
Message-ID: <422CB68A.1050900@drzeus.cx>
Date: Mon, 07 Mar 2005 21:16:10 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Mark Canter <marcus@vfxcomputing.com>,
       rlrevell@joe-job.com, nish.aravamudan@gmail.com,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
References: <4227085C.7060104@drzeus.cx>	<29495f1d05030309455a990c5b@mail.gmail.com>	<Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>	<1109875926.2908.26.camel@mindpipe>	<Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>	<1109876978.2908.31.camel@mindpipe>	<Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>	<20050303154929.1abd0a62.akpm@osdl.org>	<4227ADE7.3080100@drzeus.cx>	<4228D013.8010307@drzeus.cx> <s5hmztfwon1.wl@alsa2.suse.de>
In-Reply-To: <s5hmztfwon1.wl@alsa2.suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

>At Fri, 04 Mar 2005 22:16:03 +0100,
>Pierre Ossman wrote:
>  
>
>>It seems I spoke too soon. The defaults picked by the driver are 
>>actually fine. It seems to be alsactl store/restore that did something 
>>strange when coming from an older kernel.
>>    
>>
>
>My guess is that kmix is the cuplrit.
>kmix tends to turn on all mixer switches uncoditionally, and
>saves/restores the mixer config by itself.
>  
>
I use Gnome, not KDE so kmix is not an issue.

>Look at /etc/asound.state whether it contains the value of "Headphone
>Jack Sense" control true or false.
>  
>
It saves the setting once I've been in 2.6.11. From an earlier kernel
there is no such entry.

>BTW, the default value of this control switch was fixed for ThinkPads
>on ALSA tree since long time ago, but unfortunately the patch wasn't
>accepted for 2.6.11...
>  
>
My machine is a hp/compaq, not a thinkpad, so I don't know if it would
have any effect here.

Rgds
Pierre

