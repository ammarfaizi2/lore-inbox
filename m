Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269194AbTGUC1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 22:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269200AbTGUC1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 22:27:25 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:41373
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S269194AbTGUC1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 22:27:24 -0400
Message-ID: <3F1B5312.9040502@ghz.cc>
Date: Sun, 20 Jul 2003 22:42:26 -0400
From: Charles Lepple <clepple@ghz.cc>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 startup messages?
References: <20030720140035.GC20163@rdlg.net> <3F1AD2AA.9010603@cornell.edu> <yw1xbrvpuew9.fsf@users.sourceforge.net>
In-Reply-To: <yw1xbrvpuew9.fsf@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Ivan Gyurdiev <ivg2@cornell.edu> writes:
[...]
>>>  I just converted a box to 2.6-test1.  I've installed the
>>>module-init-tools
>>>per another thread on the list.  Spread throughout the startup messages
>>>of the system (Debian Unstable) are messages that read:
>>>FATAL: Module /dev/tts not found
>>>FATAL: Module /dev/tts not found
>>>FATAL: Module /dev/ttsS?? not found
>>>FATAL: Module /dev/ttsS?? not found
[...]
> It's the new modprobe that complains louder than the old one.  I guess
> it's trivial to remove the printout from the source code.

couldn't you just set the 'install' action for "/dev/tts", etc. to
'/bin/true'?

-- 
Charles Lepple <ghz.cc!clepple>




