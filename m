Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbRFVO7B>; Fri, 22 Jun 2001 10:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265438AbRFVO6v>; Fri, 22 Jun 2001 10:58:51 -0400
Received: from gg.gbf.de ([193.175.244.3]:14454 "EHLO rzgate.gbf.de")
	by vger.kernel.org with ESMTP id <S265437AbRFVO6j>;
	Fri, 22 Jun 2001 10:58:39 -0400
Message-ID: <3B335CEB.6030606@gbf.de>
Date: Fri, 22 Jun 2001 16:57:47 +0200
From: Joachim Reichelt <Reichelt@gbf.de>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us, de
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Deadlock
In-Reply-To: <705600000.993219515@tiny>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.7.0.1)
X-AntiVirus: OK (checked by AntiVir Version 6.7.0.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>
>On Friday, June 22, 2001 10:19:26 AM +0200 Joachim Reichelt
><Reichelt@gbf.de> wrote:
>
>>Hallo all,
>>
>
>>on the ncr is a DLT Tape
>>
>>kernel is vanilla 2.4.4
>>
>>once a month i get a deadlock of the whole system during backup.
>>What can i do
>>    to get the bug fixed
>>or
>>    to get not affected by it any longer
>>
>
>Well, can you tell which filesystem is being backed up when the system
>deadlocks?
>
>-chris
>
It crashed late in the night, so i was not there. All i have:
arkeia (our backup prog) wrote the last log at:

 > ls -ltdr `find . -newer o3_cpnt`
-rw-r--r--    1 root     root        11600 Jun 21 22:39 
./rzlimes/usr/java/jdk1.3/bin/i386/green_threads/o3_cpnt
drwxr-xr-x    2 root     root           85 Jun 21 22:39 
./rzlimes/usr/java/jdk1.3/bin/i386/green_threads
drwxr-xr-x    2 root     root           85 Jun 22 15:48 ./rzlimes/.kde

/var/log/messages ends with:
Jun 21 22:40:10 rzlimes ipop3d[30743]: connect from ...

/usr is on / which is reiserfs

-- 
Mit freundlichen Gruessen                         Best Regards
 
         Joachim Reichelt
 
SF  - Strukturforschung                                       RZ  - Rechenzentrum
              GBF - Gesellschaft fuer Biotechnologische Forschung
                    German Research Centre for Biotechnology

WWW: http://www.gbf.de        _/_/_/   _/_/_/   _/_/_/_/
EMAIL: REICHELT@gbf.de      _/    _/  _/   _/  _/
                           _/        _/   _/  _/
Mascheroder Weg 1         _/  _/    _/_/_/   _/_/_/
D-38124 Braunschweig      _/    _/  _/   _/  _/ 
Tel: +(49) 531 6181 352  _/    _/  _/   _/  _/ 
FAX: +(49) 531 2612 388   _/_/_/   _/_/_/   _/ 

NEU:
NEW:
SF: http://struktur.gbf.de/
    http://struktur.gbf.de/msf/mm.html
RZ: http://wtd.gbf.de/rz/rz.html

-- Disclaimer --
Standard > Keyword : Opinions, my own, nobody else's, whatsoever ...

Man muss sich notfalls jemand mieten,
hat man an Geist selbst nichts zu bieten!     (Heinz Erhardt)



