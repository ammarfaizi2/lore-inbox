Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbTCHUm4>; Sat, 8 Mar 2003 15:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbTCHUm4>; Sat, 8 Mar 2003 15:42:56 -0500
Received: from terminus.zytor.com ([63.209.29.3]:4275 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id <S262187AbTCHUmz>;
	Sat, 8 Mar 2003 15:42:55 -0500
Message-ID: <3E6A582A.4020700@zytor.com>
Date: Sat, 08 Mar 2003 12:52:58 -0800
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
> I agree they both the dhcp client and the nfs mount need to be in the
> same binary.  With busybox they already are so it should just take
> some glue code to have the magic work.
> 

Not necessarily -- you could pass the DHCP packets in binary file form. 
  This would also let the boot loader pass the DHCP packets instead.

	-hpa

