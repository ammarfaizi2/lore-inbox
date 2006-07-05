Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWGEFNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWGEFNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 01:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWGEFNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 01:13:22 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62933 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932322AbWGEFNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 01:13:21 -0400
Message-ID: <44AB4A68.90301@zytor.com>
Date: Tue, 04 Jul 2006 22:13:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Benny Amorsen <benny+usenet@amorsen.dk>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com>
In-Reply-To: <44AB3E4C.2000407@tmr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
>>
>> DC> Easily doable in userspace, why bother with kernel programming
>>
>> In userspace you can't automatically delete the files when the space
>> becomes needed. The LD_PRELOAD/glibc methods also have the
>> disadvantage of having to figure out where a file goes when it's
>> deleted, depending on which device it happens to reside on. Demanding
>> read access to /proc/mounts just to do rm could cause problems.
>>
>> Userspace has had 10 years to invent a good solution. If it was so
>> easy, it would probably have been done.
>>
> Actually, if it were so important it WOULD have been done. I suspect 
> that the issue is not lack of a good solution, but lack of a good 
> problem. The behavior you propose requires a lot of kernel cleverness, 
> including make the inodes seem to go away, so the count is "right" for 
> what the user sees.
> 

The real solution for it is snapshots.

	-hpa
