Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132985AbRDLUOo>; Thu, 12 Apr 2001 16:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133071AbRDLUOf>; Thu, 12 Apr 2001 16:14:35 -0400
Received: from friley-168-165.stures.iastate.edu ([129.186.168.165]:29675 "EHLO
	friley-168-165.stures.iastate.edu") by vger.kernel.org with ESMTP
	id <S132985AbRDLUOQ>; Thu, 12 Apr 2001 16:14:16 -0400
Message-ID: <3AD60D66.7010907@adiis.net>
Date: Thu, 12 Apr 2001 15:17:42 -0500
From: Ryan Butler <rbutler@adiis.net>
Organization: ADI Internet Solutions
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; 0.8.1) Gecko/20010412
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Breuninger <benb@uncontrolled.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: real-time file monitoring at the kernel level
In-Reply-To: <Pine.BSO.4.33.0104111117130.6048-100000@unf.uncontrolled.org> <3AD532EC.366DDC4C@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you might check out fam and imon (fam is userspace, imon is a kernel patch).

Both are open source SGI tools, imon is the inode monitor.

Both can be found at http://oss.sgi.com


>Hello,
>
>I was wondering if anyone has a patch, or is working on something for what
>im looking for, or if they are interested in an idea i have (forgive me if
>this is someone elses idea, ill give credit to them), for file monitoring
>at the kernel level.
>I have put up a brief explanation of what im looking for at
>http://flog.uncontrolled.org/, but in a nutshell, it is this:
>
>a kernel patch (or module) that would allow me to have, say, /proc/flog,
>which shows real-time file monitoring information, which could be tail
>-f'd like so:
>
>root@server~# tail -f /proc/flog
>modify: root "/var/log/auth.log" 20000410150229
>access: root "/etc/passwd" 20000410150324
>modify: root "/etc/passwd" 20000410150441
>remove: root "/var/log/auth.log" 20000410150502
>create: root "/usr/bin/.. /" 20000410150534
>create: root "/usr/bin/.. /backdoor" 20000410150627
>modify: bob "/home/bob/mailbox" 20000410150854
>modify: root "/var/www/htdocs/index.html" 20000410150927
>
>the above would describe a theoretical breakin from a hacker, which i
>believe would be extremely useful in intrusion detection. My idea of this
>is further outlined at http://flog.uncontrolled.org/, including
>theoretical usage, practice, description, etc.
>The reason i ask the linux-kernel community is my coding ability does not
>allow me to hack at the kernel, and so i would need help with this, or any
>other information that would point me in the right direction that im
>looking for.
>
>If someone is interested in this, or has any information whatsoever,
>please let me know!
>
>thanks,
>benb@uncontrolled.org
>
>PS: im not looking for LIDS
>


