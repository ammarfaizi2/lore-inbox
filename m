Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVAKUUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVAKUUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVAKUUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:20:11 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:21912 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262571AbVAKUUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:20:01 -0500
Message-ID: <41E434B4.9020903@nortelnetworks.com>
Date: Tue, 11 Jan 2005 14:19:00 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
CC: Matt Mackall <mpm@selenic.com>, Chris Wright <chrisw@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>	<1105132348.20278.88.camel@krustophenia.net>	<20050107134941.11cecbfc.akpm@osdl.org>	<20050107221059.GA17392@infradead.org>	<20050107142920.K2357@build.pdx.osdl.net>	<87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org>	<87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us>
In-Reply-To: <871xcr3fjc.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> Matt Mackall <mpm@selenic.com> writes:

>>Thankfully a buffer underrun is no more fatal for pro audio than a
>>broken guitar string. CDs skip, DATs glitch, XLR cables flake out,
>>circuit breakers trip, amps clip, Powerbooks crash, and the show goes
>>on. I've done more than enough stage tech to know it's a huge pain in
>>the ass, but let's stop pretending we require absolute perfection,
>>please.

> In _practice_, Ingo's patches are considerably better than what you
> seem to consider "good enough for mere audio work".

I don't see anywere that Matt was criticising Ingo's work.  He just said 
that it wasn't hard realtime--which is true.

A hard realtime system will *guarantee* that the deadlines will be met, 
*no matter what*.  It makes all kinds of other sacrifices to do it, and 
it makes additional demands on the application designer as well.

I don't think Ingo would claim that his patches make Linux a hard RT 
operating system.

Chris
