Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUJEEta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUJEEta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 00:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUJEEta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 00:49:30 -0400
Received: from wasp.net.au ([203.190.192.17]:58550 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268771AbUJEEtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 00:49:02 -0400
Message-ID: <416227E1.8020306@wasp.net.au>
Date: Tue, 05 Oct 2004 08:49:37 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Knop <wknop@andrew.cmu.edu>
CC: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: libata badness
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu> <16737.54003.419130.575839@cse.unsw.edu.au> <Pine.LNX.4.60-041.0410042301510.22333@unix47.andrew.cmu.edu>
In-Reply-To: <Pine.LNX.4.60-041.0410042301510.22333@unix47.andrew.cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Knop wrote:
> 
>> This code starts:
>>
>>   0:   8b 55 04                  mov    0x4(%ebp),%edx
>>   3:   83 c1 08                  add    $0x8,%ecx
>>
>> and as %ebp is 01000000, this oopses.
>> It looks very much like a single-bit memory error (as has already been
>> suggested as a possibility).
> 
> 
> Oh my. So, I ran memcheck again for a few hours, and it checked out 
> fine. Just in case, though, I bought a replacement stick of ram. Well, 
> the oopses went away, so it must have been the ram.

For future reference, I have had errors show up after 24-36 hours of memtest86. I usually find that 
if it passes 48 hours of testing then things are looking pretty reliable. A couple of hours is 
usually too small a sample to rely on.

Brad
