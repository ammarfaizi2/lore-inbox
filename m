Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968057AbWLEDdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968057AbWLEDdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 22:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968059AbWLEDdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 22:33:16 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:50551 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968057AbWLEDdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 22:33:15 -0500
Message-ID: <4574E86B.10403@lwfinger.net>
Date: Mon, 04 Dec 2006 21:32:59 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Benoit Boissinot <bboissin@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5-mm1 progression
References: <456718F6.8040902@lwfinger.net> <40f323d00611240836q6bcf7374gd47c7a97d1d4f8e3@mail.gmail.com> <20061125112437.3d46eff4.akpm@osdl.org>
In-Reply-To: <20061125112437.3d46eff4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 24 Nov 2006 17:36:27 +0100
> "Benoit Boissinot" <bboissin@gmail.com> wrote:
> 
>> On 11/24/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>> Is there the equivalent of 'git bisect' for the -mmX kernels?
>>>
>> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
>>
> 
> Please take the time to do that.  Yours is an interesting report - I'm not
> aware of anything in there which was expected to cause a change of this
> mature.
> 

There are at least two patches in 2.6.19-rc5-mm2 that make my system much more responsive for 
interactive jobs. The one that has the majority of the effect is:

radix-tree-rcu-lockless-readside.patch

I have not been able to isolate the second patch, which has the lesser effect. All I can say is that 
it occurred before the above patch in patches/series. This patch was tested against 2.6.19 and fixed 
most of the problem on that version.

Larry Finger


