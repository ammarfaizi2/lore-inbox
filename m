Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTENM5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTENM4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:56:39 -0400
Received: from [205.167.22.167] ([205.167.22.167]:12301 "EHLO
	mks-smtp-1.mksinst.com") by vger.kernel.org with ESMTP
	id S262142AbTENMzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:55:52 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 freeze problem.
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OF699B450E.9BF05B14-ONC1256D26.00471201-C1256D26.00482FE7@mksinternal.com>
From: Nicolae_Popovici@mksinst.com
Date: Wed, 14 May 2003 14:58:53 +0200
X-MIMETrack: Serialize by Router on MKS-ANDOVER-2/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/14/2003 09:05:42 AM,
	Serialize complete at 05/14/2003 09:05:42 AM,
	Itemize by SMTP Server on MKS-SMTP-1/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/14/2003 09:09:19 AM,
	Serialize by Router on MKS-SMTP-1/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/14/2003 09:09:25 AM,
	Serialize complete at 05/14/2003 09:09:25 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  guys,

 Here are the facts.
I have a small user program and the latest 2.4.20 stable kernel.
It is running on a board from IEI ( Wafer-5823 ) with a Cyrix 300 CPU.
 What happens is that after 2 hours of running this user program the 
computer 
freezes. I have the linux crash dump compiled inside the kernel and 
activated 
along with the magic sysrq key. Nothing works. I get only some messages 
inside 
the /var/log/messages but none of them are related to the crash ( modprobe 
says it 
can not load some module ). I also get the kcore file but I am using a 
bzImage  jkernel and I am not able to 
load it in the gdb. Should I switch to a vmlinux image ?

Any ideeas of how to move forward with this will be greatly appreciated.
Cheers,
Nicu
