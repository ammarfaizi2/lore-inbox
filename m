Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTENNY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTENNY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:24:27 -0400
Received: from prv-tm12.provo.novell.com ([192.108.102.142]:49508 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262118AbTENNY0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:24:26 -0400
Subject: Re: Compile error including asm/uaccess.h
From: "ismail donmez" <kde@smtp-send.myrealbox.com>
To: storri@sbcglobal.net
CC: linux-kernel@vger.kernel.org
Date: Wed, 14 May 2003 07:37:08 -0600
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1052919428.273b9220kde@smtp-send.myrealbox.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
In file included from /usr/include/linux/sched.h:14,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/linux/timex.h:173: field `time' has incomplete type
In file included from /usr/include/linux/sched.h:17,
                 from /usr/include/asm/uaccess.h:8,
                 from test.cpp:1:
/usr/include/asm/system.h:238: parse error before `new'
/usr/include/asm/system.h: In function `long unsigned int
__cmpxchg(...)':
/usr/include/asm/system.h:241: `size' undeclared (first use this
function)
/usr/include/asm/system.h:241: (Each undeclared identifier is reported
only 
   once for each function it appears in.)
/usr/include/asm/system.h:245: parse error before `)' token
/usr/include/asm/system.h:251: parse error before `)' token
/usr/include/asm/system.h:257: parse error before `)' token
/usr/include/asm/system.h:261: `old' undeclared (first use this
function)
</snip>

Dont include kernel headers in userspace OR define the needed variables to  make your userspace application compile.

Nice report btw 

/ismail

