Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVDMBtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVDMBtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVDMBrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:47:18 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:11714 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S262168AbVDMBoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:44:38 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de> <1113276365.5387.39.camel@gaston>
	<87u0mc8v2p.fsf@blackdown.de> <1113287657.5387.46.camel@gaston>
	<871x9fg96h.fsf@blackdown.de> <1113345600.5387.116.camel@gaston>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew
	Morton <akpm@osdl.org>, Linux Kernel list
	<linux-kernel@vger.kernel.org>
Date: Wed, 13 Apr 2005 03:44:25 +0200
In-Reply-To: <1113345600.5387.116.camel@gaston> (Benjamin Herrenschmidt's
	message of "Wed, 13 Apr 2005 08:40:00 +1000")
Message-ID: <87is2rqwli.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>>>>> Hrm... I just noticed you have CONFIG_PREEMPT enabled... Can you
>>>>> test without it and let me know if it makes a difference ?
>>>>
>>>> IIRC I had disabled that for rc2-mm2 and it didn't make a
>>>> difference.  I'll disable it again when I try older versions.
>>>>
>>>> I just got another crash with rc2-mm3.  The crash was a bit
>>>> different this time, I still could move the mouse pointer and the
>>>> logs contained some info:
>>>
>>> Ok, what about non-mm  ? (just plain rc2)
>>
>> I've tried older kernels now.  rc1-mm1 locks up (no logs); plain
>> rc1 seems to be OK (running fine for several hours now).
>
> Interesting. Please try -rc2 too...

Works fine so far.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
