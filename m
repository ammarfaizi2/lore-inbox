Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSG1L1Y>; Sun, 28 Jul 2002 07:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSG1L1Y>; Sun, 28 Jul 2002 07:27:24 -0400
Received: from imap.laposte.net ([213.30.181.7]:8368 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S315717AbSG1L1W>;
	Sun, 28 Jul 2002 07:27:22 -0400
Message-ID: <3D43C990.5030503@laposte.net>
Date: Sun, 28 Jul 2002 13:38:08 +0300
From: Johann Deneux <johann.deneux@laposte.net>
Reply-To: johann.deneux@it.uu.se
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Hards <bhards@bigpond.net.au>
CC: Vojtech Pavlik <vojtech@suse.cz>, linuxconsole-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Event API changes - EVIOCGID
References: <200207212050.56616.bhards@bigpond.net.au> <200207281745.37751.bhards@bigpond.net.au> <20020728102256.B12268@ucw.cz> <200207281842.18988.bhards@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards wrote:
> On Sun, 28 Jul 2002 18:22, Vojtech Pavlik wrote:
> 
 > [...]
> 
>>__u* is used extensively in the input API anyway, so you'd have to
>>explain it to userspace programmers nevertheless. So I prefer keeping
>>the input.h include use just one type of explicit sized types.
> 
> So do I, and it had better be a standard type.
> 
> Note that the input API does *NOT* use __u* extensively. In fact
> if you take out the force feedback stuff (which Johannes already

(Just a detail: my name is Johann)

> agreed to change:), this is the *only* _u* usage in any part of the 
> input API.
> 

I did this change in the past, but it was undone (not by me), as it 
would break user-space applications. I definitely agree to use uint16_t.

> 
>>Sure, we can change them all to uint*_t, but then do it all at once and
>>provide a satisfactory explanation for it. ;)
> 
> I am doing it all. Johannes agreed to the change, and I did the only
> other required entry. If Johannes agrees, I'll do the trivial changes
> for force-feedback.

Ok with me.

> The reason why I am not doing it all at once is to provide patches
> that do one API change at a time. Or, depending on how you look
> at it, I did the only change all-at-once, and you reverted it :)
> 
> Brad
> 

-- 
Johann Deneux

