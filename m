Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWAAVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWAAVjK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWAAVjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 16:39:10 -0500
Received: from [202.67.154.148] ([202.67.154.148]:4289 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S932258AbWAAVjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 16:39:09 -0500
Message-ID: <43B84BC4.6020502@ns666.com>
Date: Sun, 01 Jan 2006 22:38:12 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Night Owl 3.12V
X-Accept-Language: en-us
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: Jiri Slaby <xslaby@fi.muni.cz>, Sami Farin <7atbggg02@sneakemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       jesper.juhl@gmail.com, s0348365@sms.ed.ac.uk, rlrevell@joe-job.com,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <20051231163414.GE3214@m.safari.iki.fi>	<20051231163414.GE3214@m.safari.iki.fi>	<43B6B669.6020500@ns666.com> <43B73DEB.4070604@ns666.com>	<43B7D3BE.60003@ns666.com> <43B7EB99.8010604@ns666.com>	<43B7EB99.8010604@ns666.com>	<20060101183832.2BE0222AEE7@anxur.fi.muni.cz>	<20060101184916.GE27444@vanheusden.com>	<43B8256C.2060407@ns666.com> <20060101204958.GG27444@vanheusden.com>
In-Reply-To: <20060101204958.GG27444@vanheusden.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
>>>Just to add:
>>>something else is fishy: when I start iptraf (or some other traffic
>>>dumper) my system hangs up. repeatable. also with a bttv card which is
>>>occasionally used for grabbing videotext pages
>>
>>That could be an irq sharing issue i think.
> 
> 
> Nope.
> 
> 
>>Do you use also grabdisplay instead of overlay mode?
> 
> 
> No, I grab videotext pages.
> 
> 
> Folkert van Heusden
> 


small update:

using tvtime and i put a heavy load on the system there are still no
random crashes or freezes happened.

I've found many reports that xawtv might cause system instability, some
say with overlay others say grabdisplay (in my case grabdisplay). But
when i use overlay mode in xawtv then i cannot get a real fullscreen.
Tried all the recommended parameters to xawtv to get it to real
fullscreen but somehow it doesn't, only in grabdisplay. Now i'm using
tvtime and things work perfect (unless i'm speaking too early, but i'll
leave it also for the whole night running a heavy load + tv on anyway)

I hope some one can comment on these issue's and especially if the bttv
code has to do with all this ?

