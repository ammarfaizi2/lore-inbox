Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRKMVYp>; Tue, 13 Nov 2001 16:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRKMVYf>; Tue, 13 Nov 2001 16:24:35 -0500
Received: from unknown.Level3.net ([63.210.233.154]:27653 "EHLO
	cinshrexc01.shermfin.com") by vger.kernel.org with ESMTP
	id <S279277AbRKMVYU>; Tue, 13 Nov 2001 16:24:20 -0500
Message-ID: <35F52ABC3317D511A55300D0B73EB8056FCC0C@cinshrexc01.shermfin.com>
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Banasik, Bob" <BBanasik@shermanfinancialgroup.com>
Subject: Addition:  kupdated high load with heavy disk I/O
Date: Tue, 13 Nov 2001 16:24:13 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry ... addition to below.  Filesystem is ext2.

Thanks again,
Andy.

---------------------------------------------------


Hello,

I have read some previous threads about kupdated consuming 99% of CPU under
intense disk I/O in kernel 2.4.x on the archives of this list (April 2001),
but have yet to find any suggestions or fixes.  I am currently experiencing
the same issue and was wondering if anyone has any thoughts or suggestions
on the issue.  I am not subscribed to the list so would you please CC: me
directly on any responses?  Thank you.

The issue that I am having is that when there is a heavy amount a disk I/O,
the box becomes slightly unresponsive and kupdated is using 99.9% in 'top.'
Sometimes the box appears to totally lock up.  If one waits several seconds
to a couple of minutes the system appears to 'unlock' and runs sluggishly
for a while.  This cycle will repeat itself until the I/O subsides.

The issue appears in kernel 2.4.14 compiled directly from source from
kernel.org with no patches.  These problems manifest themselves with only
one user doing heavy disk I/O.  The normal user load on the box can run
between 350-450 users so this behavior would be unacceptable because the
application that is being run is interactive.  With 450 users, and the same
process running on a 2.2 kernel the performance of the box is great, with
only a very slightly noticeable slow down.

I am running the Informix database UniVerse version 9.6.2.4 on a 4 processor
700MHz Xeon Dell PowerEdge 6400.  The disk subsystem is controlled by a PERC
2/DC RAID card with 128MB on-board cache (megaraid driver compiled directly
in to the kernel).  Data array is on 5 36GB 10K Ultra160 disks in a RAID5
configuration.  The box has 4GB RAM, but is only using 2GB due to the move
back to the 2.2 kernel.

If you need any more detailed info, please let me know.  Any help on this
problem would be immensely appreciated.  Thanks in advance.

Regards,
Andrew Rechenberg
Network Team, Sherman Financial Group
arechenberg@shermanfinancialgroup.com
Phone: 513.677.7809
Fax:   513.677.7838
