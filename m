Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTKMOTO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 09:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTKMOTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 09:19:14 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:32014
	"EHLO eumucln02.muc.eu.mscsoftware.com") by vger.kernel.org with ESMTP
	id S264286AbTKMOTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 09:19:13 -0500
Message-ID: <3FB391FC.2090406@mscsoftware.com>
Date: Thu, 13 Nov 2003 15:15:24 +0100
From: "martin.knoblauch " <"martin.knoblauch "@mscsoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfs_statfs: statfs error = 116
X-MIMETrack: Itemize by SMTP Server on EUMUCLN02/MSCsoftware(Release 6.0.2CF1|June 9, 2003) at
 11/13/2003 03:19:55 PM,
	Serialize by Router on EUMUCLN02/MSCsoftware(Release 6.0.2CF1|June 9, 2003) at
 11/13/2003 03:19:58 PM,
	Serialize complete at 11/13/2003 03:19:58 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  sorry if OT, but what is above message trying to tell me? Where can I 
find a translation of the numbers? We are seeing 116 very frequently, 
512 and 5 on occasion.


  We have a bunch of Linux clients (Dual P4, RH7.3, 2.4.20-18.7smp 
errata kernel) hanging off two Sun NFS Servers (Solaris 8) in a 
Veritas/VCS HA configuration. All of the clients show the 116 messages, 
while some of them show the 512 in addition. Those with the 512s seem to 
"hang" for some periods of time.

  The mounts are "vers=3,proto=tcp,hard,intr,bg". Some of them mounted 
at boottime, quite a few via "amd".

  Any ideas are welcome.

Thanks
Martin


