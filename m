Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270165AbSISG6q>; Thu, 19 Sep 2002 02:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270206AbSISG6p>; Thu, 19 Sep 2002 02:58:45 -0400
Received: from 12-237-16-92.client.attbi.com ([12.237.16.92]:2944 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S270165AbSISG6n>; Thu, 19 Sep 2002 02:58:43 -0400
Message-ID: <3D8976CD.2020904@attbi.com>
Date: Thu, 19 Sep 2002 02:03:41 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.36-BK latest - Two Problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I am currently having two minor problems with 2.5.36-BK.  Here they are:

1)  If I boot with nmi_watchdog=1 I get the following message:

activating NMI Watchdog ... done.
testing NMI watchdog ... CPU#0: NMI appears to be stuck!

     This has been happening ever since I switched over to an SMP Athlon 
box (two Athlon MP chips) from an SMP PIII box.  It would be nice to 
have nmi_watchdog work on my athlon box.  The box is a Tyan Thunder K7 
if that helps, I can send any other information that would help with 
this problem.

2)  The last 2.5.xx kernel I tried before this was 2.5.33-mm5 which 
worked pretty well.  Now at boot up and shutdown I get a lot of messages 
like the following:

cdrom: open failed.

     From what I can tell when the message happens the system seems to 
be waiting on the cdrom and it always seems like my old scsi-1 Plextor 
40x SCSI CD-ROM is making noise around then.  This does not happen with 
any other kernel that I use and my Yamaha SCSI scsi/mmc-3 drive does not 
seem to be effected either, any ideas on what that could be?


   Please let me know if you need any information to figure out what is 
going on with either of the above problems.

Jordan Breeding

