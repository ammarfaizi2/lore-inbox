Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbSJNROh>; Mon, 14 Oct 2002 13:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262077AbSJNROh>; Mon, 14 Oct 2002 13:14:37 -0400
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:35323 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S262076AbSJNROg>; Mon, 14 Oct 2002 13:14:36 -0400
Message-ID: <3DAAFCF9.A1CACE33@pp.inet.fi>
Date: Mon, 14 Oct 2002 20:20:57 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loop on top of NFS hangs kernel
References: <3DAAF2DF.9010809@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> I have a small problem with my configuration which results in a deadlock
> after ~1 minute. As soon as the copying hangs, I can still switch to another
> console but not execute any command or write anything to any disk. SysRq-S
> and SysRq-U both never complete and the output of SysRq-P or SysRq-T never
> hits the disk.
[snip]
> Kernel is 2.4.18-SuSE. I'm willing to try any 2.4 (or for that matter, 2.5)
> kernel or additional patches if this helps.
> 
> _This hang could also be reproduced without any encryption._

Mainline loop is buggy beyod belief (and so was SuSE's last time I looked).
Can you try to reproduce that error with this loop crypto package:

http://mail.nl.linux.org/linux-crypto/2002-10/msg00015.html

Twofish cipher in the 'ciphers' package is SuSE compatible with appropriate
mount option. Read README files in the tarballs for more information.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

