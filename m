Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269871AbUIDK5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269871AbUIDK5s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269876AbUIDK5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:57:48 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:1221 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269871AbUIDK5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:57:45 -0400
Message-ID: <41399FA4.7050104@tungstengraphics.com>
Date: Sat, 04 Sep 2004 11:57:40 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <41399CA2.3080607@yahoo.com.au>
In-Reply-To: <41399CA2.3080607@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Keith Whitwell wrote:
> 
>> Christoph Hellwig wrote:
>>
>>> On Sat, Sep 04, 2004 at 11:23:35AM +0100, Keith Whitwell wrote:
>>>
>>>>> Actually regulat users do.  And they do by pulling an uptodate 
>>>>> kernel or
>>>>> using a vendor kernel with backports.  This model would work for 
>>>>> video drivers
>>>>> aswell.
>>>>
>>>>
>>>>
>>>> Sure, explain to me how I should upgrade my RH-9 system to work on 
>>>> my new i915?
>>>
>>>
>>>
>>>
>>> Download a new kernel.org kernel or petition the fedora legacy folks to
>>> include a drm update.  The last release RH-9 kernel has various security
>>> and data integrity issues anyway, so you'd be a fool to keep running it.
>>
>>
>>
>> OK, I've found www.kernel.org, and clicked on the 'latest stable 
>> kernel' link.  I got a file called "patch-2.6.8.1.bz2".  I tried to 
>> install this but nothing happened.  My i915 still doesn't work.  What 
>> do I do now?
>>
> 
> Just out of interest, what would the scenario be if you do if you could
> get a compatible driver?

Nick, I'm sorry I couldn't quite parse your question.

Ideally, everybody would have all the drivers they need right there on the 
media they got their distribution on, and if not, they'd be able to pull them 
over quick smart from their vendor online.

The biggest problem the DRI had in the early years was believing that you 
could get a new driver released to the public though the DRI tree, then an 
XFree86 CVS merge and XFree86 release, a Linux kernel release, maybe making it 
into vendor updates for X and kernel, but more likely the next full RedHat 
release,  and ultimately into users hands in a reasonable amount of time. 
Typically it was 6 months to a year for this process to roll through.

Given that we seldom had access to pre-release hardware, that meant that users 
were getting drivers about the time that cards became obsolete.

A couple of things have changed since then - DRI drivers for the i915 were 
available at launch of the hardware, not 6 months later.  But the rest of the 
process is still pretty slow, which is why the DRI snapshots and downloadable 
binaries were a significant step forward - if nvidia in particular can get 
uptodate drivers quickly into the hands of unsophisticated users, you have to 
ask yourself why users of DRI hardware should be forced to wait 6 months and 
then jump through hoops just to get their video cards working.

Keith
