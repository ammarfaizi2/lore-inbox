Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbTLZUOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTLZUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:14:24 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:27500 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265232AbTLZUOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:14:22 -0500
Message-ID: <3FEC969D.4080502@rackable.com>
Date: Fri, 26 Dec 2003 12:14:21 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Mike Fedyk <mfedyk@matchmail.com>, Stan Bubrouski <stan@ccs.neu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: is it possible to have a kernel module with a BSD license?!
References: <3FE9ADEE.1080103@baywinds.org> <1072303285.2947.215.camel@duergar> <20031224221024.GA6438@matchmail.com> <Pine.LNX.4.58.0312241510150.7586@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.58.0312241510150.7586@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Dec 2003 20:14:21.0573 (UTC) FILETIME=[D9593B50:01C3CBEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> the question comes back to looking if it's derived from the linux kernel.
> 
> if it is then it must be GPL (GPL doesn't allow anything else)
> 
> if it isn't then it can be becouse the GPL is compatable with BSD code.
> (it becomes GPL for purposes of the kernel, but is also available for
> other uses under the BSD license)
> 
> however the big question as always remains 'is this derived from the
> kernel code'


   Well it's obviously derived if any of the following is true:

1)You are using any linux you borrowed from gpl sources.
2)The module uses a lot internal kernel hooks.

Linus claims that is it's derived if:

1)It only supports linux.  (He's got a point.)
2)It was originally written for linux. (I'd disagree, but IANAL)


Certainly you'd have a leg to stand on if:
1)The module was really cross platform.  (Extra points for it working on 
*BSD, or the like 1st.)
2)The linux headers are clearly marked gpl.
3)Every accessing internal linux kernel functions was in the linux headers.
4)Everything in the module was gpl, or bsd.  (Less to do things being 
derived than with if you can legally use the result.)

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

