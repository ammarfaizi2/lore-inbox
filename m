Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262203AbTCHVAW>; Sat, 8 Mar 2003 16:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262205AbTCHVAW>; Sat, 8 Mar 2003 16:00:22 -0500
Received: from terminus.zytor.com ([63.209.29.3]:36019 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S262203AbTCHVAT>; Sat, 8 Mar 2003 16:00:19 -0500
Message-ID: <3E6A5C44.9060002@zytor.com>
Date: Sat, 08 Mar 2003 13:10:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>	<Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>	<20030307233916.Q17492@flint.arm.linux.org.uk>	<m1d6l2lih9.fsf@frodo.biederman.org>	<20030308100359.A27153@flint.arm.linux.org.uk> <m18yvpluw7.fsf@frodo.biederman.org>
In-Reply-To: <m18yvpluw7.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> The last time I worked on something like this I put a dhcp client, and
> a tftp client in a single binary, my compressed initrd was only 16K on
> x86.  And I had a complete network boot loader using the linux kernel.
> 
> Now the kernel is so big and bloated it has not been practical to use
> it.  So my effort has mostly been concentrated on etherboot.  Which
> is essentially a mini-kernel that just focuses on being a network boot
> loader.  And with etherboot I can get a udp/ip stack. With dhcp and
> tftp support, and an eepro100 nic driver into 38K on an Itanium (The
> platform with possible the most bloated binaries known to man).  On x86
> with an eepro100 driver I can usually get it down to around 16K.  (All
> sizes represent self decompressing executables).
> 

Incidentally, any hope of getting Etherboot to act as a PXE stack any 
time soon?

	-hpa (ducks & runs)


