Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWIDOsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWIDOsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWIDOsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:48:38 -0400
Received: from lucidpixels.com ([66.45.37.187]:34486 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751442AbWIDOsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:48:36 -0400
Date: Mon, 4 Sep 2006 10:48:35 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       apiszcz@lucidpixels.com
Subject: Re: [NFS] 2.6.17.6 New(?) NFS Kernel Bug (OOPS) When vi /over/nfs/file.txt
In-Reply-To: <17660.5710.887383.554921@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0609041048210.1572@p34.internal.lan>
References: <Pine.LNX.4.64.0608310708050.2348@p34.internal.lan>
 <17660.5710.887383.554921@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, whoa, thanks for this and identifying the patch fix!

Justin.

On Mon, 4 Sep 2006, Neil Brown wrote:

> On Thursday August 31, jpiszcz@lucidpixels.com wrote:
>> Short description: I have a text file I was editing over NFS, around 4 to
>> 5 kilobytes.  It was during this time this occured:
>>
>> Note, this is the first time I have ever seen this bug.
>> My .config is attached.  After a reboot, I ran the same vi command, no
>> issues, so I could easily reproduce the problem.
>>
>> Could anyone offer any insight to exactly what it was that caused this
>> bug?
>
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2f34931fdc78b4895553aaa33748939cc7697c99
>
> This is fixed in a 2.6.17.11 and possibly earlier stable releases.
>
> NeilBrown
>
