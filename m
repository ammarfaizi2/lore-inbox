Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263179AbTC1Whz>; Fri, 28 Mar 2003 17:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263180AbTC1Whz>; Fri, 28 Mar 2003 17:37:55 -0500
Received: from freeside.toyota.com ([63.87.74.7]:2959 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S263179AbTC1Whx>; Fri, 28 Mar 2003 17:37:53 -0500
Message-ID: <3E84D153.6090803@tmsusa.com>
Date: Fri, 28 Mar 2003 14:48:51 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete messages ...
References: <Pine.LNX.4.50.0303261857290.970-100000@blue1.dev.mcafeelabs.com> <1048774874.19677.0.camel@rth.ninka.net> <20030327232607.GC16251@suse.de> <Pine.LNX.4.50.0303271539230.2009-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>Well, usually /etc/inittab calls /sbin/update ( bdflush ). About
>SO_BSDCOMPAT I can report Bind 9.2.2 but I think their code is right. They
>do check for "#ifdef SO_BSDCOMPAT", that is still defined in asm/socket.h.
>By removing SO_BSDCOMPAT from asm/socket.h and rebuilding, it should be
>fine.
>
ACK! - commenting out the SO_BSDCOMPAT
line in asm/socket.h and rebuilding the bind rpms
cured the plague of syslog msgs here (RH 8.0)


Best Regards,

Joe

