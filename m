Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129291AbRBLJO1>; Mon, 12 Feb 2001 04:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129382AbRBLJOR>; Mon, 12 Feb 2001 04:14:17 -0500
Received: from gg.gbf.de ([193.175.244.3]:1755 "EHLO rzgate.gbf.de")
	by vger.kernel.org with ESMTP id <S129291AbRBLJOK>;
	Mon, 12 Feb 2001 04:14:10 -0500
Message-ID: <3A87A951.8040205@gbf.de>
Date: Mon, 12 Feb 2001 10:13:53 +0100
From: Joachim Reichelt <Reichelt@gbf.de>
Organization: Gesellschaft für Biotechnologische Forschung mbH
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hang on MO 1k HW-Blocksize
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel writers,

i got a total system hang, whenever i try to write to my mo drives.

This are 615 MB removebal drive with 1024 byte bloacksize and vfat filesys.
They are scsi I drive 5MB/sec bus speed.
On one system it is on an old ncr:SCSI storage controller: Symbios Logic 
Inc. (formerly NCR) 53c810 (rev 02)

Type: Sequential-Access ANSI SCSI revision: 02
Vendor: Maxoptix Model: T3-1304 Rev: 11ba
Type: Optical Device ANSI SCSI revision: 02
ncr53c810-0-<5,0>: tagged command queue depth set to 8   

On a second system i got an adaptec 2940 amd an IBM drive.

All is fine on any 2.2 kernal
All is locked writing to the MO using 2.4.0 or 2.4.1

What can i do to get a working system with 2.4.x and/or
to catch the bug.

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
