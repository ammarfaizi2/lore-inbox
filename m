Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131414AbRAXAJx>; Tue, 23 Jan 2001 19:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132061AbRAXAJo>; Tue, 23 Jan 2001 19:09:44 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:20276 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S131414AbRAXAJh>; Tue, 23 Jan 2001 19:09:37 -0500
Message-Id: <4.3.2.7.2.20010123160116.00bb4180@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 23 Jan 2001 16:07:26 -0800
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        jearle@nortelnetworks.com,
        Linux Kernel List <linux-kernel@vger.kernel.org>
From: Stephen Satchell <satch@fluent-access.com>
Subject: RE: [OT?] Coding Style
In-Reply-To: <200101231647.KAA39761@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:47 AM 1/23/01 -0600, Jesse Pollard wrote:
>Code is written by the few.
>Code is read by the many, and having _ in there makes it MUCH easier to
>read. Visual comparison of "SomeFunctionName" and "some_function_name"
>is faster even for a coder where there may be a typo (try dropping a 
>character)
>or mis identifing two different symbols with similar names:
>
>         d_hash_mask
>         d_hash_shift
>
>This is relatively easy to read. conversely:
>
>         DHashMask
>         DHashShift
>
>Are more difficult to spot.

Depends on what you are used to.  I'm used to both, being both an old-world 
C programmer from the very beginning (where underscore was the preferred 
way) and also a Pascal programmer (where the mixed-case form was the 
preferred way).  Remember a language where dollar signs broke up words?

But then again, one reason I'm so fond of structures is that you can get 
away from the whole thing by being able to read

        d.hash.mask
        d.hash.shift

(It's really too bad that you can't have structured enum constants, isn't it?)

By the way, just so everyone hates me, I would tend to key the above two 
names as

      DHash_mask
      DHash_shift

so that, as another person has commented, you identify the class of a 
variable and the specifics as easily identifiable entities.  That assumes 
that your "class" names are sufficiently different that a mis-key will be 
caught by that master of book-keeping, the compiler.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
