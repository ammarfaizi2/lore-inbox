Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbRAWQra>; Tue, 23 Jan 2001 11:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbRAWQrU>; Tue, 23 Jan 2001 11:47:20 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:38265 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130417AbRAWQrE>; Tue, 23 Jan 2001 11:47:04 -0500
Date: Tue, 23 Jan 2001 10:47:00 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101231647.KAA39761@tomcat.admin.navo.hpc.mil>
To: jearle@nortelnetworks.com,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: [OT?] Coding Style
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jonathan Earle" <jearle@nortelnetworks.com>:
> I prefer descriptive variable and function names - like comments, they help
> to make code so much easier to read.
> 
> One thing I wonder though... why do people prefer 'some_function_name()'
> over 'SomeFunctionName()'?  I personally don't like the underscore character
> - it's an odd character to type when you're trying to get the name typed in,
> and the shifted character, I find, is easier to input.

Code is written by the few.
Code is read by the many, and having _ in there makes it MUCH easier to
read. Visual comparison of "SomeFunctionName" and "some_function_name"
is faster even for a coder where there may be a typo (try dropping a character)
or mis identifing two different symbols with similar names:

	d_hash_mask
	d_hash_shift

This is relatively easy to read. conversely:

	DHashMask
	DHashShift

Are more difficult to spot. 

In this case "The good of the many outweigh the good of the few".

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
