Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264848AbTE1TkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264849AbTE1TkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:40:17 -0400
Received: from 4.54.252.64.snet.net ([64.252.54.4]:7563 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S264848AbTE1TkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:40:16 -0400
Message-ID: <3ED513BB.8080800@blue-labs.org>
Date: Wed, 28 May 2003 15:53:31 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030527
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <3ED3A2AB.3030907@gmx.net> <3ED3A55E.8080807@storadinc.com> <200305271954.11635.m.c.p@wolk-project.de> <20030528071608.GA5801@moonkingdom.net>
In-Reply-To: <20030528071608.GA5801@moonkingdom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, odd.  I see similar dead time in 2.5.x, it is annoying but I 
haven't had any time to track it down.  I'm currently on .69 and 
planning on putting .70 on this evening.

David

Marc Wilson wrote:

>On Tue, May 27, 2003 at 08:04:49PM +0200, Marc-Christian Petersen wrote:
>  
>
>>ALL: Anyone who has this kind of pauses/stops/mouse is dead/keyboard is dead/:
>>     speak _NOW_ please, doesn't matter who you are!
>>    
>>
>
>Ok, add my box to the list.  Variety of post 2.4.18 kernels, -ac's, -rc's,
>etc... all demonstrate it to one degree or another.
>
>Lately it's gotten REALLY bad.
>
>Currently I'm using 21-rc2-ac2 and it freezes for upwards of 15 sec
>regularly when I'm exercising the HD (three simultaneous brag threads
>downloading from various newsgroups).  The mouse moves, but other than
>that, X is entirely unresponsive.  An xterm with continually scrolling
>text, for example, will appear to stop scrolling until the kernel comes
>back.
>
>The HD light is on solid the whole time.
>
>21-rc2 does it too.  I haven't tried anything later than that yet. Well, I
>tried 20-ck7 and it ate my RAID0 due to a DMA-ism and I've not tested
>anything else since. :(
>


