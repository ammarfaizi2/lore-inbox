Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265443AbRGBWSU>; Mon, 2 Jul 2001 18:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265441AbRGBWSA>; Mon, 2 Jul 2001 18:18:00 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:13063 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S265440AbRGBWRz>; Mon, 2 Jul 2001 18:17:55 -0400
Message-ID: <3B40F36D.3080701@missioncriticallinux.com>
Date: Mon, 02 Jul 2001 18:19:25 -0400
From: "Patrick O'Rourke" <orourke@missioncriticallinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.9.1) Gecko/20010607 Netscape6/6.1b1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "SATHISH.J" <sathish.j@tatainfotech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reg crash utility installation
In-Reply-To: <Pine.LNX.4.10.10107012004510.30427-100000@blrmail>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SATHISH.J wrote:

> I installed crash2.6 on my machine. 
> When I give the command "crash" from the prompt it says "no debugging
> symbols found in /boot/vmlinux2.2.14-12". Why does this message show.


crash relies on debug info and so it needs access to an uncompressed
vmlinux file which was built using -g.  The following URL offers more
info:

	http://oss.missioncriticallinux.com/projects/crash/usage.php

Pat

-- 
Patrick O'Rourke
orourke@missioncriticallinux.com

