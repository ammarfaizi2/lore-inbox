Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSLGW2m>; Sat, 7 Dec 2002 17:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSLGW1V>; Sat, 7 Dec 2002 17:27:21 -0500
Received: from khms.westfalen.de ([62.153.201.243]:3225 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S264853AbSLGW1P>; Sat, 7 Dec 2002 17:27:15 -0500
Date: 07 Dec 2002 23:18:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: mochel@osdl.org
cc: linux-kernel@vger.kernel.org
Message-ID: <8bPzeb7mw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0212061601550.1010-100000@localhost.localdomain>
Subject: Re: /proc/pci deprecation?
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.33.0212061601550.1010-100000@localhost.localdomain>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mochel@osdl.org (Patrick Mochel)  wrote on 06.12.02 in <Pine.LNX.4.33.0212061601550.1010-100000@localhost.localdomain>:

> But, look the usage model. Who queries PCI information from the system? I
> would argue a) developers, b) power users, and c) users hitting a bug.
>
> a) are going to use lspci, since it's much more powerful. b) may use
> either text format, but it's also likely they'll use a graphical tool.
> Looking at my gnome setup, I do not find anything that lists PCI devices
> (besides a file browser in sysfs :).  And, c) are most likely going to use
> lspci becaus a developer asks for it. I do not remember the last time I
> saw someone ask for the output of /proc/pci. :)

Hmm. Seems I am in neither group.

I use cat /proc/pci for the same reason I use cat /proc/scsi - when  
configuring a box, or adding new hardware, to figure out what I should  
look for and where it is.

I don't particularly care which part of the file system this omes from,  
but I do care about being able to find it quickly, and about it being easy  
(i.e. not need looking at 7868 separate files) and giving the essential  
info (which is the info that can be found in the relevant docs or be fed  
to google).

> I totally agree with you. But, I don't think the answer is in
> consolidating files; I think it's in writing intelligent and efficient
> tools to grok that data.

I seriously distrust tool-based solutions for this. It is far too likely  
that any new tool will be missing when I most need it, and old tools  
already aren't a particularly convincing solution.

I don't want to grovel through 7868 tools just as I don't want to grovel  
through 7868 files. And the more those are, the less likely I am to even  
have heard of them - from the lsXXX tools, the only one I knew about was  
lspci, and lsusb (which seems to be the other one actually installed)  
seems to be a lot more reluctant to give useful info to the non-USB- 
expert.

MfG Kai
