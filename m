Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIOis>; Tue, 9 Jan 2001 09:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIOij>; Tue, 9 Jan 2001 09:38:39 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:36160 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129324AbRAIOi1>; Tue, 9 Jan 2001 09:38:27 -0500
Date: Tue, 9 Jan 2001 08:38:23 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101091438.IAA52632@tomcat.admin.navo.hpc.mil>
To: viro@math.psu.edu, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: `rmdir .` doesn't work in 2.4
cc: andrea@suse.de, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 9 Jan 2001, Jesse Pollard wrote:
> 
> > Not exactly valid, since a file could be created in that "pinned" directory
> > after the rmdir...
> 
> No, it couldn't (if you can show a testcase when it would - please do, you've
> found a bug). Moreover, busy directories can be removed in 2.4 quite fine -
> it's about pathname, not about the thing being your (or somebody else) pwd.

Apologies to all, foot-in-mouth disease....

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
