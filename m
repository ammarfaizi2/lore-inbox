Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272813AbTGaH6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272835AbTGaH6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:58:06 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:3502 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272813AbTGaH6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:58:01 -0400
Date: Thu, 31 Jul 2003 05:01:04 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: ianh@iahastie.clara.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t2 Hangs randomly
Message-Id: <20030731050104.1b61990d.vmlinuz386@yahoo.com.ar>
In-Reply-To: <3F28C124.9070004@gts.it>
References: <3F27817A.8000703@gts.it>
	<200307302346.02989.ianh@iahastie.local.net>
	<3F28C124.9070004@gts.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 09:11:32 +0200, Stefano Rivoir wrote:
>Ian Hastie wrote:
>> On Wednesday 30 Jul 2003 09:27, Stefano Rivoir wrote:
>> 
>
>> 
>> What makes you think this is a hang?  Does the disc activity stop? 
>If you > press the caps lock or num lock keys does the LED light up? 
>What I'm asking > is could it have been swapping for some reason?  I've
>had the system go > unresponsive on me quite recently, also when
>running KDE.  It easilly took a > two or more minutes to start
>responding again.  The disc light stayed active > all the time it
>wasn't responding.
>
>No, it hangs. No cursor movement, no keyboard reaction, no ping on
>eth0, no disc activity except for 3/4 seconds following. I left it like
>that 10/15 minutes then I had to power it off...

I have similar symptom when the freeze happen. No disk activity, no
mouse, no keyboard, the open sessions ssh not to respond, no ping, etc. 
Until this moment, I happen to me only once, but it takes advantage of
east message to comment to them of the experience.
In any case if experiment these freeze, I return to them to communicate
of the problem, and in any case I test some parameter of starting
or options of compilation that you they recommend to me.

About other beta versions of kernel I cannot comment to them because
not them probe.  2.6.0-test1 probe just a short time.

Lamentably it is not left anything registered in logs, only combinacion
of keys that responds is sysrq-reboot.
sysrq-sync and sysrq-umount not respond (no disk activity).

Running: kernel compilation (over ext3) ,
X 4.3 (DRI no in use), KDE,Mozilla(downloading file over xfs)
,Sylpheed,Xchat, and in the reiser fs partition no activitie.

When reboot fsck deleted orphaned entrys from /tmp (ext3) and no others
problems in others filesystems.


My .config, dmesg and lspci.
http://www.vmlinuz.com.ar/slackware/kernel.config.djgera/config-2.6.0-test2
http://www.vmlinuz.com.ar/slackware/info-hard/dmesg-2.6.0-test2-djgera
http://www.vmlinuz.com.ar/slackware/info-hard/lspci-2.6.0-test2-djgera


(sorry my english)
-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
