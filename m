Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129483AbQJ0Qh1>; Fri, 27 Oct 2000 12:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQJ0QhK>; Fri, 27 Oct 2000 12:37:10 -0400
Received: from fe8.southeast.rr.com ([24.93.67.55]:48649 "EHLO
	mail8.triad.rr.com") by vger.kernel.org with ESMTP
	id <S129483AbQJ0Qgf>; Fri, 27 Oct 2000 12:36:35 -0400
Message-ID: <39F9AF0E.70406@triad.rr.com>
Date: Fri, 27 Oct 2000 12:36:30 -0400
From: Jason Wohlgemuth <jswkernel@triad.rr.com>
Organization: SELF
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test9 i686; en-US; m18) Gecko/20000929 Netscape6/6.0b3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: GPL Question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider this:

A subsystem that is statically built into the Linux Kernel is modified 
to allow the registration of a structure containing function pointers.

The function pointers corrolate to a set of functions within that subsystem.
If the new structure of pointers has been registered, the original 
functions will call the new functions in the structure passing all 
arguments and returning the return value of the new function.

With this said, if no structure has been registered, then no 
functionality is degraded within the kernel.  Only the loss of some cpu 
time to check the pointers at the top of the old functions.

Now, if a module is loaded that registers a set of functions that have 
increased functionality compared to the original functions, if that 
modules is not based off GPL'd code, must the source code of that module 
be released under the GPL?

Thanks in advance,
Jason Wohlgemuth

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
