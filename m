Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVDLTZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVDLTZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVDLTXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:23:25 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:19363 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S262202AbVDLSIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:08:11 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de> <1113276365.5387.39.camel@gaston>
	<87u0mc8v2p.fsf@blackdown.de> <1113287657.5387.46.camel@gaston>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew
	Morton <akpm@osdl.org>, Linux Kernel list
	<linux-kernel@vger.kernel.org>
Date: Tue, 12 Apr 2005 20:08:06 +0200
In-Reply-To: <1113287657.5387.46.camel@gaston> (Benjamin Herrenschmidt's
	message of "Tue, 12 Apr 2005 16:34:16 +1000")
Message-ID: <871x9fg96h.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2005-04-12 at 06:42 +0200, Juergen Kreileder wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>
>>> On Tue, 2005-04-12 at 03:18 +0200, Juergen Kreileder wrote:
>>>> Andrew Morton <akpm@osdl.org> writes:
>>>>
>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
>>>>
>>>> I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.
>>>>
>>>> 2.6.11-mm4 works fine but all 2.6.12 versions I've tried (all
>>>> since -rc1-mm3) lock up randomly.  The easiest way to reproduce
>>>> the problem seems to be running Azareus.  So it might be network
>>>> related, but I'm not 100% sure about that, there was a least one
>>>> deadlock with virtually no network usage.
>>>
>>> Hrm... I just noticed you have CONFIG_PREEMPT enabled... Can you
>>> test without it and let me know if it makes a difference ?
>>
>> IIRC I had disabled that for rc2-mm2 and it didn't make a
>> difference.  I'll disable it again when I try older versions.
>>
>> I just got another crash with rc2-mm3.  The crash was a bit
>> different this time, I still could move the mouse pointer and the
>> logs contained some info:
>
> Ok, what about non-mm  ? (just plain rc2)

I've tried older kernels now.  rc1-mm1 locks up (no logs); plain rc1
seems to be OK (running fine for several hours now).

        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
