Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292986AbSCFJu5>; Wed, 6 Mar 2002 04:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSCFJus>; Wed, 6 Mar 2002 04:50:48 -0500
Received: from [195.63.194.11] ([195.63.194.11]:61957 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292986AbSCFJua>; Wed, 6 Mar 2002 04:50:30 -0500
Message-ID: <3C85E627.1030800@evision-ventures.com>
Date: Wed, 06 Mar 2002 10:49:27 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16iPUx-0004vD-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>I intend to kill the largely overdesigned taskfile stuff. It's broken
>>by design to provide this micro level of device access to *anybody*.
>>Operating systems should try to present the functionality of devices
>>in a convenient way to the user and not just mapp it directly to
>>user space.
>>
> 
> Martin - please go and use a macintosh for 8 weeks then come back. The
> unix philosophy is make the simple things easy make the complex possible. 

Add "and do as much in user-space" in esp. if the stuff is anyway only
suitable for root and we agree. My main objection is just
the way the driver commands are exposed to user space and the
way they are validated in kernel space.

