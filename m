Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbUBPPUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265627AbUBPPUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:20:42 -0500
Received: from [195.23.16.24] ([195.23.16.24]:42956 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265620AbUBPPUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:20:32 -0500
Message-ID: <4030DFBB.7010801@grupopie.com>
Date: Mon, 16 Feb 2004 15:20:27 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: RANDAZZO@ddc-web.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: what to use (sem/spinlock/etc)....
References: <89760D3F308BD41183B000508BAFAC4104B16F79@DDCNYNTD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RANDAZZO@ddc-web.com wrote:

> I have a register on my hardware that I write to to increment a counter....
> ..all I want to do is make sure that only one "task" writes at a time, 
> thus to not corrupt the value......
> 
> =EXAMPLE
> 
> Task A
> - Write new Value to hardware
> - Increment Hardware counter
> - DONE
> 
> Task B
> - Write new Value to hardware
> - Increment Hardware counter
> - DONE
> 
> ..This will most likely not occur in a inthandler, but may....
> 
> ...I have to make sure that Task A is "done" before "Task B" or any others
> can do their writing....
> 
> ...any opinion of what I should use....

You can read the "Unreliable Guide To Locking" from Rusty Russell at:

http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

