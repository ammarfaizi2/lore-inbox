Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313240AbSDDQWw>; Thu, 4 Apr 2002 11:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSDDQWg>; Thu, 4 Apr 2002 11:22:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8758 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313240AbSDDQVK>; Thu, 4 Apr 2002 11:21:10 -0500
To: Craig <penguin@wombat.ca>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4: BOOTPC /proc info.
In-Reply-To: <Pine.LNX.4.42.0204031837450.711-100000@wombat>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2002 09:13:54 -0700
Message-ID: <m1pu1fqw59.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig <penguin@wombat.ca> writes:

> Yes, Alan mentions the same thing.
> We didn't realize that was the long term plan.  Is that documented anywhere, or
> was it discussed on this list eons ago and 'decided'? ;)

It has been discussed on this list several times.  In fact every time
this has come up.  There are a lot of policy decisions the in kernel
dhcp/bootpc code that are generally best left to user space.  

Al Viro has gone so far as proposed moving a lot of other parts into
user space as well.  But initramfs needs to be in the kernel for that.

Eric
