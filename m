Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132037AbRDNLfw>; Sat, 14 Apr 2001 07:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbRDNLfm>; Sat, 14 Apr 2001 07:35:42 -0400
Received: from mailsrv1.dlink.com.tw ([210.66.49.71]:17417 "EHLO
	mailsrv1.dlink.com.tw") by vger.kernel.org with ESMTP
	id <S132037AbRDNLf2>; Sat, 14 Apr 2001 07:35:28 -0400
From: vivid_liou@dlink.com.tw
X-Lotus-FromDomain: D-LINK
To: linux-kernel@vger.kernel.org
Message-ID: <48256A2E.003F9F29.00@dlink.com.tw>
Date: Sat, 14 Apr 2001 19:39:16 +0800
Subject: why can't include /sys/types and /linux/fs.h in the same file
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear All:
I wrote a very small program as following :
#include <kernel/fs.h>
#include <sys/types.h>
int main ()
{
;  // contains no C programs,
}
and give the command " cc  -D__KERNEL__ -I/usr/src/linux/include  to compiler
the program .
A lot of parser error messages show on the screen .
Does anybody know why ?


