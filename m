Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSEUHqg>; Tue, 21 May 2002 03:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSEUHqf>; Tue, 21 May 2002 03:46:35 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:41705 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S316541AbSEUHqd>; Tue, 21 May 2002 03:46:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ivan Gyurdiev <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Compiler question....
Date: Mon, 20 May 2002 19:40:40 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02052019404000.15624@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.17

Should the compiler be blamed or the code?
gcc 2.96 compiles it. 3.1 won't.
Before people yell at me to use the recommended compiler, I would like to say
that it really wouldn't solve the problem. Compilers move forward, the code 
has to comply. Therefore I'm excersing my right to ignore all warnings about 
my compiler and use it. If this is a bug in the compiler, I'd agree and 
switch back to 2.96. Otherwise I'd suggest the code be changed.
Comments or advice?

In file included from attrib.h:31,
                 from debug.h:31,
                 from ntfs.h:40,
                 from aops.c:29:
layout.h:299: unnamed fields of type other than struct or union are not 
allowed
layout.h:1450: unnamed fields of type other than struct or union are not 
allowed
layout.h:1466: unnamed fields of type other than struct or union are not 
allowed
layout.h:1715: unnamed fields of type other than struct or union are not 
allowed
layout.h:1892: unnamed fields of type other than struct or union are not 
allowed
layout.h:2052: unnamed fields of type other than struct or union are not 
allowed
layout.h:2064: unnamed fields of type other than struct or union are not 
allowed
