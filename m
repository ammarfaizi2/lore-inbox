Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272065AbRHVRsG>; Wed, 22 Aug 2001 13:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272063AbRHVRr4>; Wed, 22 Aug 2001 13:47:56 -0400
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:46833 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S272055AbRHVRrn>; Wed, 22 Aug 2001 13:47:43 -0400
Importance: Normal
Subject: Is there any interest in Dynamic API
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF7D8B08B8.41635C2F-ON80256AB0.0060953B@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Wed, 22 Aug 2001 18:44:27 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.6 |December 14, 2000) at
 22/08/2001 18:45:04
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering whether the kernel community had any interest in seeing a
dynamic api capability in the kernel. What I have in mind the ability for a
kernel module to request a system call entry be added by supplying a call
name to a create_dynamic_api service. This service would assign a system
call number by looking for an unused slot (not from the beginning of the
syscall table but from a defined location so as to avoid reserved calls).
It would create a /proc/dynapi/api_name - the content of this file would
contain the call number.

It seems like a harmless enough idea. And I sort of like the idea of using
a system call rather than turning a kernel module into a device driver just
for the sake of a user communication mechanism.  I envisage this being of
use to projects where they need a user-kernel interface but not a generic
one.

Comments please.


Richard Moore -  RAS Project Lead - Linux Technology Centre (ATS-PIC).
http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK

