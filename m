Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSGGWu6>; Sun, 7 Jul 2002 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSGGWu5>; Sun, 7 Jul 2002 18:50:57 -0400
Received: from smtp.comcast.net ([24.153.64.2]:46445 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S316610AbSGGWuz>;
	Sun, 7 Jul 2002 18:50:55 -0400
Date: Sun, 07 Jul 2002 18:55:02 -0400
From: Justin Hibbits <jrh29@po.cwru.edu>
Subject: Re: Patch for Menuconfig script (CC all replies to me personally)
To: rhw@infodead.org
Cc: linux-kernel@vger.kernel.org
Message-id: <3D28C6C6.9070208@po.cwru.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's for any 'sh' compliant shell.  I'll look into checking for all sh-compatible shells,
until then, I hope you like it :) (took a ton of time to do this...).  Also, I only tested
it with 2.4.18 (but it can very easily be adapted for the 2.5.xx kernels, and should work
with any other 2.4.xx kernel without any modification, but I guarentee nothing :P )

Oh, I hope this doesn't start another thread (I'm using mozilla to send, and mutt to receive,
so there may be problems).


Thanks for you reply, and I thank you and all other kernel hackers for a job well done
(I look forward for 2.6 :) )

Justin Hibbits

--You wrote--
Hi Justin.

> This is just a patch to the Menuconfig script (can be easily adapted
> to the other ones) that allows you to configure the kernel without
> the requirement of bash (I tested it with ksh, in POSIX-only mode).  
> Feel free to flame me :P

Does it also work in the case where the current shell is csh or tcsh
(for example)? If not, you will need to replace the test for bash with a
test for bash or ksh or ... instead, as otherwise it will still fail.
Certainly on the systems I've used where bash isn't available, tcsh has
been far commoner than ksh.

Best wishes from Riley.




