Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129219AbQKWUhc>; Thu, 23 Nov 2000 15:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129295AbQKWUhM>; Thu, 23 Nov 2000 15:37:12 -0500
Received: from babylon5.babcom.com ([208.176.30.226]:26752 "EHLO
        babylon5.babcom.com") by vger.kernel.org with ESMTP
        id <S129219AbQKWUhI>; Thu, 23 Nov 2000 15:37:08 -0500
Date: Thu, 23 Nov 2000 12:07:01 -0800
From: Phil Stracchino <alaric@babcom.com>
To: Linux-KERNEL <linux-kernel@vger.kernel.org>, support@vmware.com
Subject: VMWare will not run on kernel 2.4.0-test11
Message-ID: <20001123120701.A1338@babylon5.babcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: Yes
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
X-Copyright: This message may not be reproduced, in part or in whole, for any commercial purpose without prior written permission.  Prior permission for BUGTRAQ is implicit.
X-UCE-Policy: No unsolicited commercial email is accepted at this site.  The sending of any UCE to this domain may result in the imposition of civil liability against the sender in accordance with Cal. Bus. & Prof. Code Section 17538.45, and all senders of UCE will be permanently blocked.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just compiled and installed kernel 2.4.0-test11.  Upon rebooting,
vmware-2.0.3-786 refused to run.  Running vmware-config.pl resulted in a
the following message:

	"Your processor does not have a Time Stamp Counter. VMware will
	 not run on this system."

Since (1) my hardware has not changed, (2) this VMware release ran
perfectly on 2.4.0-test10, and (3) I changed nothing but the kernel in
between 2.4.0-test10 and 2.4.0-test11, I feel quite confident in believing
that I do indeed possess a Time Stamp Counter (whatever such a fabulous
beast may be), but for some reason VMware is unable to detect its presence
when running on kernel 2.4.0-test11.  Evidently there has been some change
in the kernel which renders VMware unable to detect this mysterious - but
apparently crucial - feature.


I would appreciate any insights from either kernel folks or VMware folks
as to where this problem may lie, with an eventual aim of patching either
VMware or the kernel to allow VMware to run on this kernel.



-- 
 Linux Now!   ..........Because friends don't let friends use Microsoft.
 phil stracchino   --   the renaissance man   --   mystic zen biker geek
    Vr00m:  2000 Honda CBR929RR   --   Cage:  2000 Dodge Intrepid R/T
 Previous vr00mage:  1986 VF500F (sold), 1991 VFR750F3 (foully murdered)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
