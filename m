Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312534AbSCYVJn>; Mon, 25 Mar 2002 16:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312571AbSCYVJY>; Mon, 25 Mar 2002 16:09:24 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.31]:5302 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S312534AbSCYVJS>; Mon, 25 Mar 2002 16:09:18 -0500
Date: Mon, 25 Mar 2002 16:09:16 -0500
From: Matthew Drobnak <mdrobnak@optonline.net>
Subject: IPv6 anomolies on the PowerPC platform
To: linux-kernel@vger.kernel.org
Message-id: <3C9F91FC.5040104@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, this is my first posting to the kernel mailing list, so 
please bear with me...

	I have a Apple Power Macintosh 7200/120, which is a PowerPC 601 based 
computer, running Debian Testing. I was using Yellow Dog Linux 2.1 
before, running kernel 2.4.17. I currently use 2.4.16-newpmac from Debian.

	When running 2.4.17, if you tried to make a connection to the machine via 
IPv6 it would work sometimes, but fail most of the times. Taking the 
interface down and bringing it back up would fix the problem for 
approximately 1 - 2 minutes. It also did not pick up an address, as it 
should have, as I run radvd on my router (linux also). Note this was 
with IPv6 compiled in, not a module.

	I had hoped it was something other than kernel related, so I re-installed 
linux, using Debian, over this past weekend. Now, however, problems are 
worse. As well as not getting an address, even manually configuring the 
address does not work. It is not pingable at all using IPv6, nor do any 
connections (like to apache) work.

	Any pointers on where to start debugging this would be appreciated, as I 
would like to try and get it working correctly. I am not the most 
experienced programmer in the world, but I would try and make a best 
effort attempt to help in any way that I can to help resolve this 
matter. I also have a G3 iBook (tangerine) that I have not tested, as I 
did not get around to recompiling a kernel for yet.


Thank you for your time,

-Matthew Drobnak

