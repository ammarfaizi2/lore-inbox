Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143387AbREKULS>; Fri, 11 May 2001 16:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143378AbREKULD>; Fri, 11 May 2001 16:11:03 -0400
Received: from cs140085.pp.htv.fi ([213.243.140.85]:40620 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S143383AbREKUJt>; Fri, 11 May 2001 16:09:49 -0400
Message-ID: <3AFC46FA.D60CA20E@pp.htv.fi>
Date: Fri, 11 May 2001 23:09:30 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon possible fixes
In-Reply-To: <200105051626.SAA16651@cave.bitwizard.nl> <3AF4824F.8964E53B@home.com> <3AF57F63.9900089E@pp.htv.fi> <000b01c0d658$a19163a0$3303a8c0@pnetz>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:
> 
> Can you try and mail me if the Kernel 2.4.3 (without any ac patch) is 
> stable with your system even if you use autotune? "Downgrade" to this 
> kernel works fine for me.

Ahmm, 2.4.3 doesn't work. Gives some IDE DMA timeouts on boot. Kernel was
compiled with Pentium-MMX processor setting, but I don't know if that's
enough to disable the Athlon code parts (autodetected at runtime?).

So only working kernel (without noautotune) on that A7V133 machine is
RedHat's 2.4.2-2 shipped with RedHat 7.1... But that's not good either
because the system has large reiserfs volume and 2.4.2-2 has some reiserfs
bugs.

I really start hating IDE/ATA stuff again.

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
