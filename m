Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262461AbTCIHXg>; Sun, 9 Mar 2003 02:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbTCIHXd>; Sun, 9 Mar 2003 02:23:33 -0500
Received: from h-64-105-35-18.SNVACAID.covad.net ([64.105.35.18]:31360 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262461AbTCIHX3>; Sun, 9 Mar 2003 02:23:29 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 8 Mar 2003 23:34:01 -0800
Message-Id: <200303090734.XAA01410@adam.yggdrasil.com>
To: akpm@digeo.com, jason@jeetkunedomaster.net
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-03-09, Andrew Morton wrote:
>Jason Straight <jason@JeetKuneDoMaster.net> wrote:
>>
>> I get the usual loading kernel, uncompressing, booting.
>> 
>> After it tells me it's booting the kernel I see no more screen activity at 
>> all, but it is finishing the boot process. It does leave that text on the 
>> screen, but nothing more.
>> 
>> I don't have any odd type console like serial or paralell unless there's 
>> something I mistakenly turned on.
>> 
>
>You need to enable "Support for console on virtual terminal",
>aka CONFIG_VT_CONSOLE.

There may be more to this problem.

I have a 2.5.64bk3 kernel with CONFIG_VT_CONSOLE=y.  It boots fine
on one P4 desktop computer, with regular output on the console.

On another desktop computer (a P3), I get no kernel printk's but user
level programs print their output.  For example I see fsck print its
output.  However, that computer system hangs after fsck apparently
finishes.  The computer with the console problems under 2.5.64bk3
boots 2.5.64 and 2.5.64bk1 fine.  I haven't tried 2.5.64bk2 yet.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
