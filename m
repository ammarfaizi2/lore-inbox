Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSHIMOc>; Fri, 9 Aug 2002 08:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318281AbSHIMOb>; Fri, 9 Aug 2002 08:14:31 -0400
Received: from smtp4.vol.cz ([195.250.128.43]:5389 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S318275AbSHIMOa>;
	Fri, 9 Aug 2002 08:14:30 -0400
Message-ID: <3D53B1E5.1010301@illich.cz>
Date: Fri, 09 Aug 2002 14:13:25 +0200
From: Michal Illich <michal@illich.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 crash
References: <3D53931A.7060300@illich.cz> <1028894485.28882.208.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Happened again, now with "kernel BUG at buffer.c:510!" message.
> Looks very much like random memory corruption. Could be many things.
> Does the box pass memtest86 ?

It just passed memtest-2.93.1 (I don't have physical access to machine to 
run standalone test). BIOS memcheck also runs ok. It usually crashes after 
1-5 days, in the meantime all programs run perfectly.

---------------------------------------------------- memtest.log:

Testing 469684224 bytes at 0x42136000 (4088 bytes lost to page alignment).

Run    1:
   Test  1:         Stuck Address:  Setting...Passed.
   Test  2:          Random value:  Setting...Testing...Passed.
   Test  3:        XOR comparison:  Setting...Testing...Passed.
   Test  4:        SUB comparison:  Setting...Testing...Passed.
   Test  5:        MUL comparison:  Setting...Testing...Passed.
   Test  6:        DIV comparison:  Setting...Testing...Passed.
   Test  7:         OR comparison:  Setting...Testing...Passed.
   Test  8:        AND comparison:  Setting...Testing...Passed.
   Test  9:  Sequential Increment:  Setting...Testing...Passed.
   Test 10:            Solid Bits:  Setting...Passed.
   Test 11:      Block Sequential:  Setting...Passed.
   Test 12:          Checkerboard:  Setting...Passed.
   Test 13:            Bit Spread:  Setting...Passed.
   Test 14:              Bit Flip:  Setting...Passed.
   Test 15:          Walking Ones:  Setting...Passed.
   Test 16:        Walking Zeroes:  Setting...Passed.
Run    1 completed in 1476 seconds (0 tests showed errors).
munlock'ed memory.
1 runs completed.  0 errors detected.  Total runtime:  1476 seconds.




