Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2SDF>; Fri, 29 Dec 2000 13:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2SCz>; Fri, 29 Dec 2000 13:02:55 -0500
Received: from mail2.stonesoft.com ([192.89.38.188]:26641 "HELO
	mail2.stonesoft.com") by vger.kernel.org with SMTP
	id <S129930AbQL2SCn>; Fri, 29 Dec 2000 13:02:43 -0500
Subject: Bugs in knfsd -- Problem re-exporting an NFS share
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFC9E1D243.E23DCAED-ONC12569C4.005FB1E8@stonesoft.com>
From: Frank.Olsen@stonesoft.com
Date: Fri, 29 Dec 2000 18:33:13 +0100
X-MIMETrack: Serialize by Router on sharon/Stone(Release 5.0.5 |September 22, 2000) at
 29.12.2000 19:32:14
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -- could you please CC me if you reply to this mail.

My problem is that I get an error when setting up the following
configuration:

A:     /exports/A                                 - Redhat 7.0
B1/B2: mount /exports/A on /export/A from A       - Redhat 6.2
C:     mount /exports/A on /mnt/A from B1 or B2   - Redhat 6.2

I use knfsd/nfs-utils on each machine.

bash# ls /mnt/A
/mnt/A/A.txt: No such file or directory


I searched for a while on deja.com, and there seemed to be some indications
that knfsd was bugged and that using the user-mode code would work.
However, no one replied specifically to my message, so I'm still not sure.

BTW, what I tried to do was to set up a HA configuration of machines B1/B2
using A as a "shared disk".
This is just to try out the HA software without buying more hardware.

Thanks in advance for any help!

Best regards,
Frank Olsen

PS Happy new year!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
