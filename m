Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbREPR0z>; Wed, 16 May 2001 13:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262021AbREPR0p>; Wed, 16 May 2001 13:26:45 -0400
Received: from cs140085.pp.htv.fi ([213.243.140.85]:34888 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S262020AbREPR0T>; Wed, 16 May 2001 13:26:19 -0400
Message-ID: <3B02B824.6FAF5125@pp.htv.fi>
Date: Wed, 16 May 2001 20:25:56 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA/PDC/Athlon
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested 2.4.4-ac9 today on A7V133 machine. It booted up, but can't stand
any load. It will deadlock (without oops) when the network/disk system faces
any load.

There is also some new bug in VIA IDE driver. It misdetects cable as 80-w
when it's only 40-w and causes some CRC errors and speed dropping. Some
older kernels correctly detected the cable as 40-w and used UDMA33, this one
tries to use UDMA100 and fails (of course). Is there any way to force cable
detection to 40-w?

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
