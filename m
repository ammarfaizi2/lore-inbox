Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137129AbREKNKR>; Fri, 11 May 2001 09:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137131AbREKNKH>; Fri, 11 May 2001 09:10:07 -0400
Received: from [213.165.223.158] ([213.165.223.158]:384 "EHLO
	alpha.linuxassembly.org") by vger.kernel.org with ESMTP
	id <S137129AbREKNJ4>; Fri, 11 May 2001 09:09:56 -0400
Date: Fri, 11 May 2001 17:13:51 +0400 (MSD)
From: Konstantin Boldyshev <konst@linuxassembly.org>
To: <linux-kernel@vger.kernel.org>
Subject: serial console broken in 2.4.4?
Message-ID: <Pine.LNX.4.33L.0105111659530.536-100000@alpha.linuxassembly.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have noticed strange serial console behaviour in 2.4.4.
I have system with gettys on ttyS0 and tty1.
When I boot with usual console (set to tty1), getty on ttyS0 works.
When I boot with console set to ttyS0 ("console=ttyS0,9600n8"),
getty on ttyS0 doesnot respond on input (although ps shows it running);
all kernel messages are showed on ttyS0, but it seems that _input_ is
disallowed/broken. Things were okay somewhere around (AFAIR) 2.4.0pre..
Is this a known 2.4 bug? Any patch to fix this?

-- 
Regards,
Konstantin

