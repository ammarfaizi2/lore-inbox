Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135223AbRDLQo5>; Thu, 12 Apr 2001 12:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135224AbRDLQor>; Thu, 12 Apr 2001 12:44:47 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:62470 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S135223AbRDLQom>; Thu, 12 Apr 2001 12:44:42 -0400
Message-ID: <3AD532EC.366DDC4C@opersys.com>
Date: Thu, 12 Apr 2001 00:45:32 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Ben Breuninger <benb@uncontrolled.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: real-time file monitoring at the kernel level
In-Reply-To: <Pine.BSO.4.33.0104111117130.6048-100000@unf.uncontrolled.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You may want to take a look at the Linux Trace Toolkit which may
be used to do what you ask for.

http://www.opersys.com/LTT

Karim

Ben Breuninger wrote:
> 
> Hello,
> 
> I was wondering if anyone has a patch, or is working on something for what
> im looking for, or if they are interested in an idea i have (forgive me if
> this is someone elses idea, ill give credit to them), for file monitoring
> at the kernel level.
> I have put up a brief explanation of what im looking for at
> http://flog.uncontrolled.org/, but in a nutshell, it is this:
> 
> a kernel patch (or module) that would allow me to have, say, /proc/flog,
> which shows real-time file monitoring information, which could be tail
> -f'd like so:
> 
> root@server~# tail -f /proc/flog
> modify: root "/var/log/auth.log" 20000410150229
> access: root "/etc/passwd" 20000410150324
> modify: root "/etc/passwd" 20000410150441
> remove: root "/var/log/auth.log" 20000410150502
> create: root "/usr/bin/.. /" 20000410150534
> create: root "/usr/bin/.. /backdoor" 20000410150627
> modify: bob "/home/bob/mailbox" 20000410150854
> modify: root "/var/www/htdocs/index.html" 20000410150927
> 
> the above would describe a theoretical breakin from a hacker, which i
> believe would be extremely useful in intrusion detection. My idea of this
> is further outlined at http://flog.uncontrolled.org/, including
> theoretical usage, practice, description, etc.
> The reason i ask the linux-kernel community is my coding ability does not
> allow me to hack at the kernel, and so i would need help with this, or any
> other information that would point me in the right direction that im
> looking for.
> 
> If someone is interested in this, or has any information whatsoever,
> please let me know!
> 
> thanks,
> benb@uncontrolled.org
> 
> PS: im not looking for LIDS
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
