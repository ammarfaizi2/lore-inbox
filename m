Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129520AbQJ0R4d>; Fri, 27 Oct 2000 13:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbQJ0R4X>; Fri, 27 Oct 2000 13:56:23 -0400
Received: from web6104.mail.yahoo.com ([128.11.22.98]:53777 "HELO
	web6104.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129520AbQJ0R4R>; Fri, 27 Oct 2000 13:56:17 -0400
Message-ID: <20001027175616.5512.qmail@web6104.mail.yahoo.com>
Date: Fri, 27 Oct 2000 10:56:16 -0700 (PDT)
From: Anil kumar <anils_r@yahoo.com>
Subject: mkraid
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  
 I have a problem with mkraid 

 I am working on a Red hat Linux ver 7.0
 kernel version: 2.2.16
 No raid patch
 no raid tools

 when I run
 #mkraid /dev/md0
  
  when I check /proc/mdstat,I find md0 active
  with raid information.
  
  But when again I run 
  #mkraid /dev/md0
  I get an message:
  handling MD device /dev/md0
  analyzing super-block
  disk 0:/dev/hde1,2109681kB,raid superblock at 
         2109568KB
  /dev/hde1 appears to be already part of a raid
array-- use -f to force desctruction of the old
superblock
mkraid: aborted,see the syslog and /proc/mdstat for
         potential clues.

 I tried -f option, but no use.

I did a reboot and once again mkraid, but still
 I get the above messages.
 Please let me know where am I wrong , How can I
 do mkraid succesfully again?

 Expecting reply from you

with regards,
  Anil

__________________________________________________
Do You Yahoo!?
Yahoo! Messenger - Talk while you surf!  It's FREE.
http://im.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
