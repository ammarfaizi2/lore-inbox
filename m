Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTIDDSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTIDDSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:18:39 -0400
Received: from [203.185.132.124] ([203.185.132.124]:11576 "EHLO MrChoke")
	by vger.kernel.org with ESMTP id S264549AbTIDDSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:18:37 -0400
Message-ID: <3F56AF00.8030002@opentle.org>
Date: Thu, 04 Sep 2003 10:18:24 +0700
From: Supphachoke Suntiwichaya <mrchoke@opentle.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030413
X-Accept-Language: th,en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre3
References: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
Content-Type: text/plain; charset=TIS-620; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>Hello, here goes -pre3. Most changes are network and network driver
>updates. We also have DRM supporting XFree 4.3 now.
>  
>
oh.. Thank!!

>As one may have noticed from my email address I got a new job: Cyclades is 
>now sponsoring my kernel work.
>
>  
>
I can't make xconfig ::

[root@potter linux-2.4.23-pre3]# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.23-pre3/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/char/Config.in: 270: bad if condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.23-pre3/scripts'
make: *** [xconfig] Error 2
 

hmm.. ACPI can't sleep on TOSHIBA Satelliie 2410  I wait for  long time...

cat /proc/acpi/sleep
S0 S3 S4 S4Bios S5

MrChoke

-- 

Name : Supphachoke Suntiwichaya
Email : MrChoke@opentle.org
URL : http://www.opentle.org/~mrchoke/
Distribution : Linux TLE 5.0 (Andaman)
OS : Linux 2.4.22-rc2-ac3 #1 ¾Ä. Ê.¤. 21 18:51:09 ICT 2003 i686 GNU/Linux
Uptime :  10:10:00  up 20:40,  3 users,  load average: 1.46, 1.21, 1.08


