Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUFGVOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUFGVOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbUFGVOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:14:19 -0400
Received: from mail.scienion.de ([141.16.81.54]:3730 "EHLO
	server03.hq.scienion.de") by vger.kernel.org with ESMTP
	id S265065AbUFGVOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:14:03 -0400
Message-ID: <40C4DA94.2090102@scienion.de>
Date: Mon, 07 Jun 2004 23:13:56 +0200
From: Sebastian Kloska <kloska@scienion.de>
Reply-To: kloska@scienion.de
Organization: Scienion AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       psycho@albatross.co.nz, hugh@veritas.com, Matt_Domsch@dell.com
Subject: Re: APM realy sucks on 2.6.x
References: <40C0E91D.9070900@scienion.de>	 <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de>	 <20040607140511.GA1467@elf.ucw.cz> <40C47B94.6040408@scienion.de>	 <20040607144841.GD1467@elf.ucw.cz> <1086638000.2220.8.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1086638000.2220.8.camel@teapot.felipe-alfaro.com>
X-MIMETrack: Itemize by SMTP Server on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 23:23:00,
	Serialize by Router on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 23:23:07,
	Serialize complete at 07.06.2004 23:23:07
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Felipe ....

  Lucky one ...

  I do not even use PCMCIA and don't have the stuff
  compiled in or use the modules ... but the reaction
  to echo -n '3' >/proc/acpi/sleep is weired.

  Somthing like (1) The first time nothing happens
  and (2) On the second run the machine reboots....


  Up until now I've been slowly upgrading my kernel
  from minimal functionality to almost perfect

  now USB, and ALSA has been added to the kernel
  and I still can suspend/resume....

  Now of cause I'm wandering what actually triggers
  the crash ....

  That might take some time ....

  Thanks for the tip

  Sebastian

Felipe Alfaro Solana wrote:
> On Mon, 2004-06-07 at 16:48 +0200, Pavel Machek wrote:
> 
> 
>>HP sells compaq nx5000 notebooks with Linux preloaded. Unfortunately
>>suspend-to-RAM is not there (IIRC). That's because suspend-to-RAM is
>>hard to do with ACPI.
> 
> 
> It took some time for me to work, but now ACPI S3 (suspend to RAM) is
> finally working for me (I have been trying it since 2.4.22 with no
> luck). Only one thing is required before suspending:
> 
> # modprobe ds
> # cardctl eject
> 
> This ejects my CardBus NIC before going to sleep. Not doing so, causes
> the system to freeze when resuming.
> 

