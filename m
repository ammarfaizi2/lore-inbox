Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSBMOZ4>; Wed, 13 Feb 2002 09:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBMOZo>; Wed, 13 Feb 2002 09:25:44 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:26613
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S284933AbSBMOZi>; Wed, 13 Feb 2002 09:25:38 -0500
Message-ID: <3C6A775A.3090906@debian.org>
Date: Wed, 13 Feb 2002 15:25:30 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carlo <carlo@senior.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with menuconfig after installation of IPSec ( FreeS/WAN )
In-Reply-To: <fa.hehsqiv.ji8r2g@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlo wrote:

> After install of FreeS/WAN 1.95 ( IPSec )   ( make menugo ) , when I try to
> select Networking Options from menuconfig, the following screen apears...
> 
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
> 
>  Q> scripts/Menuconfig: MCmenu7: command not found
> 
> Please report this to the maintainer <mec@shout.net>.  You may also
> send a problem report to <linux-kernel@vger.kernel.org>.
> 
> Please indicate the kernel version you are trying to configure and
> which menu you were trying to enter when this error occurred.
> 
> make: *** [menuconfig] Error 1
> 
> I am running kernel 2.2.19 on Slackware 8 distro 
> 
> What can I do ? 
> 


This seem like a script error in configuration file (no or
missplaced 'fi'.)
Try 'make xconfig' (xconfig have a better error checking)

	giacomo



