Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTENNWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTENNWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:22:18 -0400
Received: from prv-tm12.provo.novell.com ([192.108.102.142]:51019 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262050AbTENNWR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:22:17 -0400
Subject: Re: Compile error including asm/uaccess.h
From: "ismail donmez" <kde@smtp-send.myrealbox.com>
To: storri@sbcglobal.net
CC: bug-glibc@gnu.org, linux-kernel@vger.kernel.org
Date: Wed, 14 May 2003 07:34:57 -0600
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1052919297.aaa917c0kde@smtp-send.myrealbox.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
====== Errors (C++) ==========

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

</snip>

Well rule of thumb says "Do not include kernel headers in userspace" second rule of thumb says "if you have to do so take care of variables that is need to be defined..."

