Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbUKXLeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbUKXLeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 06:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUKXLeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 06:34:00 -0500
Received: from tri-e2k.ethz.ch ([129.132.112.23]:57614 "EHLO tri-e2k.ethz.ch")
	by vger.kernel.org with ESMTP id S262620AbUKXLd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 06:33:57 -0500
Message-ID: <41A470F9.4000407@dbservice.com>
Date: Wed, 24 Nov 2004 12:31:05 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>
CC: linux-kernel@vger.kernel.org, greg@kroah.com,
       dri-devel@lists.sourceforge.net
Subject: Re: Kernel thoughts of a Linux user
References: <200411181859.27722.gjwucherpfennig@gmx.net> <419CFF73.3010407@dbservice.com> <41A19E44.9080005@hist.no> <41A1CAD4.20101@dbservice.com> <41A46085.5050602@hist.no>
In-Reply-To: <41A46085.5050602@hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2004 11:31:06.0129 (UTC) FILETIME=[162D2810:01C4D219]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
>> From the [ruby patch] documentation:
>> The main problem up to this date (November 2004) is that linux kernel 
>> has only one behaviour regarding multiple keyboards : any key pressed 
>> catched on any keyboard is redirected to the one and only active 
>> Virtual Terminal (VT).
>>
>> Will this be changed/improved when the console code is moved into 
>> userspace, like some have proposed?
> 
> 
> I don't know about any userspace console, but the ruby patch lets
> you have several independent active VTs at the same time.  So
> the above mentioned problem is solved - they keyboards does
> not interfere with each other.
> 

I think the it would be much nicer to habe the console code in 
userspace, ruby is only a patch, not in the mainline kernel, and AFAIK 
not even in any experimental (-mm/-ac/-etc) tree.
There are many aproaches how to solve the problem of having more than 
one ative VT, and the userspace console seems to be the nicest one.

I know that Jon Smirl wrote an email some time ago, here it is: 
http://lkml.org/lkml/2004/8/2/111, look at point 15. I like the idea and 
I've written him several times, but he didn't answer :(
Anyone knows what's happened with him?
I know he's involved in the DRM development, so I CC to the dri-devel list.

I'd really like to help with this, as I like and share his ideas.

Is anyone already working on this? I mean pulling the console code out 
of the kernel into the userspace.

tom
