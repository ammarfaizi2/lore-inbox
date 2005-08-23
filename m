Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVHWXUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVHWXUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVHWXUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:20:05 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:38555 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932492AbVHWXUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:20:03 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 23 Aug 2005 16:21:00 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Willy Tarreau <willy@w.ods.org>
cc: Davy Durham <pubaddr2@davyandbeth.com>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
In-Reply-To: <20050823202018.GA28724@alpha.home.local>
Message-ID: <Pine.LNX.4.63.0508231618420.7257@localhost.localdomain>
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl>
 <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl>
 <430B01FB.2070903@davyandbeth.com> <20050823191254.GB10110@alpha.home.local>
 <430B077A.10700@davyandbeth.com> <20050823194557.GC10110@alpha.home.local>
 <430B0EAE.9080504@davyandbeth.com> <20050823202018.GA28724@alpha.home.local>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005, Willy Tarreau wrote:

> On Tue, Aug 23, 2005 at 06:55:26AM -0500, Davy Durham wrote:
>> Thanks for the info.. I did find this thread and was wondering if this
>> patch ever got put in
>>
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0303.3/1139.html
>>
>
> Interesting ! At least it does not seem to be present in the
> epoll-2.4.24-0.20 I have right here, and although the code changed
> significantly in 2.6, it does not seem to contain it either. But I
> don't even see how to merge this into 2.6. You should ask Davide,
> he knows this code better than anyone else, and could tell us if
> this patch was simply lost or is unneeded.

I should mention that the 2.4 patch is old WRT mainline epoll in 2.6 (I 
stopped maintaining it when 2.6 went "stable"). I'd definitely suggest to 
use 2.6 if you are looking at epoll.



- Davide

