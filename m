Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbSJJV1I>; Thu, 10 Oct 2002 17:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262261AbSJJV1H>; Thu, 10 Oct 2002 17:27:07 -0400
Received: from ns2.welch-spires.org ([63.224.205.131]:28851 "EHLO
	linux.superlucidity.net") by vger.kernel.org with ESMTP
	id <S262260AbSJJV1H>; Thu, 10 Oct 2002 17:27:07 -0400
Message-ID: <3DA5F1FA.7070901@superlucidity.net>
Date: Thu, 10 Oct 2002 14:32:42 -0700
From: Zach Welch <zwelch@superlucidity.net>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vojtech Pavlik <vojtech@suse.cz>, Maciej Babinski <maciej@imsa.edu>
Subject: Re: uinput oops in 2.5.41
References: <20021009035041.A6226@imsa.edu> <20021009114238.A11161@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, Oct 09, 2002 at 03:50:41AM -0500, Maciej Babinski wrote:
> 
>>I get a NULL pointer dereference by running "cat" on /dev/misc/uinput
>>I'm a newbie, but I think the patch at the bottom fixes it.
> 
> 
> Your patch is almost correct - you have to keep both the checks. The
> first could happen when the device disappears while being waited for.
> 

I've added this to my backport to 2.4.  I'll be posting it very shortly 
under the subject 'backport of uinput.c to 2.4, fixes for 2.5'.  This 
will include numerous additional fixes to uinput.c.

Cheers,

Zach Welch
Superlucidity Services

