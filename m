Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280771AbRKBSfg>; Fri, 2 Nov 2001 13:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280774AbRKBSf0>; Fri, 2 Nov 2001 13:35:26 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:31238 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S280773AbRKBSfR>;
	Fri, 2 Nov 2001 13:35:17 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>
Date: Fri, 2 Nov 2001 19:34:49 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Weird /proc/meminfo output on 2.4.13-ac5
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <80D19CC2E32@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Nov 01 at 14:10, Andreas Franck wrote:
> $ cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  789250048 781295616  7954432   659456 402890752
> 18446744073478758400
> Swap: 6744576000   282624 6744293376
> MemTotal:       770752 kB
> MemFree:          7768 kB
> MemShared:         644 kB
> Buffers:        393448 kB
> Cached:       4294741680 kB     <------ This is impossible, i think? :-)

Problem appeared in my 2.4.13-ac4 yesterday at home too. It happened to 
me when I was checking health of my HDD - either during 'dd if=/dev/hde1 
of=/dev/null bs=8M', or during copying all files from VFAT (/dev/hde1) 
partition to /dev/null on filesystem level file by file. 

And if we are talking about it, 2.4.13-ac4 here at work reports that
too. But strange thing is that this machine has just 200MB VFAT partition
of no use, and I do not remember that I ever did read from /dev/hd* since
last reboot. Shift-scrolllock does not report any unusual values. 

I'll upgrade to -ac6 and I'll see.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
