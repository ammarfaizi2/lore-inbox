Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132620AbRDKQPt>; Wed, 11 Apr 2001 12:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132622AbRDKQPj>; Wed, 11 Apr 2001 12:15:39 -0400
Received: from uncontrolled.org ([209.134.138.193]:41084 "EHLO
	unf.uncontrolled.org") by vger.kernel.org with ESMTP
	id <S132620AbRDKQP3>; Wed, 11 Apr 2001 12:15:29 -0400
Date: Wed, 11 Apr 2001 11:19:31 +0000 (GMT)
From: Ben Breuninger <benb@uncontrolled.org>
To: <linux-kernel@vger.kernel.org>
Subject: real-time file monitoring at the kernel level
Message-ID: <Pine.BSO.4.33.0104111117130.6048-100000@unf.uncontrolled.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was wondering if anyone has a patch, or is working on something for what
im looking for, or if they are interested in an idea i have (forgive me if
this is someone elses idea, ill give credit to them), for file monitoring
at the kernel level.
I have put up a brief explanation of what im looking for at
http://flog.uncontrolled.org/, but in a nutshell, it is this:

a kernel patch (or module) that would allow me to have, say, /proc/flog,
which shows real-time file monitoring information, which could be tail
-f'd like so:

root@server~# tail -f /proc/flog
modify: root "/var/log/auth.log" 20000410150229
access: root "/etc/passwd" 20000410150324
modify: root "/etc/passwd" 20000410150441
remove: root "/var/log/auth.log" 20000410150502
create: root "/usr/bin/.. /" 20000410150534
create: root "/usr/bin/.. /backdoor" 20000410150627
modify: bob "/home/bob/mailbox" 20000410150854
modify: root "/var/www/htdocs/index.html" 20000410150927

the above would describe a theoretical breakin from a hacker, which i
believe would be extremely useful in intrusion detection. My idea of this
is further outlined at http://flog.uncontrolled.org/, including
theoretical usage, practice, description, etc.
The reason i ask the linux-kernel community is my coding ability does not
allow me to hack at the kernel, and so i would need help with this, or any
other information that would point me in the right direction that im
looking for.

If someone is interested in this, or has any information whatsoever,
please let me know!

thanks,
benb@uncontrolled.org

PS: im not looking for LIDS

