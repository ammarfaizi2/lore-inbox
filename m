Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288326AbSAQIer>; Thu, 17 Jan 2002 03:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288333AbSAQIei>; Thu, 17 Jan 2002 03:34:38 -0500
Received: from jester.ti.com ([192.94.94.1]:28069 "EHLO jester.ti.com")
	by vger.kernel.org with ESMTP id <S288327AbSAQIeS>;
	Thu, 17 Jan 2002 03:34:18 -0500
Message-ID: <3C468C7D.6000909@ti.com>
Date: Thu, 17 Jan 2002 09:34:05 +0100
From: christian e <cej@ti.com>
Organization: Texas Instruments A/S,Denmark
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: aa works for me..rrmap didn't
In-Reply-To: <Pine.LNX.4.33L.0201161923450.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Wed, 16 Jan 2002, christian e wrote:



> Ahhhhh ok.
> 
> I think your workload (leaving a huge process inactive for
> a few minutes, then switching desktops to that process)
> really does need a special VM tuning knob.
> 
> I guess I'll add a knob like this to the -rmap VM.
> 
> I'll try to keep it a bit simpler than vm_max_mapped too,
> it would seem it's possible to set vm_max_mapped so high
> that the box will refuse swapping under any circumstance
> and the box will just crash if you have too much RAM ;)))
> (then again, root can always do this)


Can I get such a patch ?? The 'not swap under any circumstances patch' 
;-)  Just what I'm looking for..

After running since yesterday the aa patched kernel is now swapping 
2260k ...

best regards

Christian



