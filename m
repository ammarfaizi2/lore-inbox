Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTJ3NjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTJ3NjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:39:14 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:38571 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262482AbTJ3NjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:39:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Question on SIGFPE
Date: Thu, 30 Oct 2003 19:07:44 +0530
Message-ID: <94F20261551DC141B6B559DC4910867217764F@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on SIGFPE
Thread-Index: AcOe6QcV1fkQgp7bQGWeMveWLvSwiwAAW92Q
From: "Sreeram Kumar Ravinoothala" <sreeram.ravinoothala@wipro.com>
To: <root@chaos.analogic.com>
Cc: "Magnus Naeslund(t)" <mag@fbab.net>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Oct 2003 13:39:02.0862 (UTC) FILETIME=[2E5966E0:01C39EEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr Johnson,
	Thanks for the mail and sorry for pestering you. Actually the
call __setfpucw is not visible anywhere. Should I use 
 _FPU_SETCW(cw) instead of that?

Thanks and Regards
SReeram

---Never doubt that a small group of thoughtful, committed people can
change the world. Indeed, it is the only thing that ever has. -- Copied
from a mail
 

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Thursday, October 30, 2003 6:56 PM
To: Sreeram Kumar Ravinoothala
Cc: Magnus Naeslund(t); Linux kernel
Subject: RE: Question on SIGFPE


On Thu, 30 Oct 2003, Sreeram Kumar Ravinoothala wrote:

>
> Hi Mr Johnson,
>     Thanks for the mail. Actually I see that there is no fpu_control.h

> in my src.
>
> Thanks and Regards
> SReeram

With more recent C runtime libraries, the header is
/usr/include/fpu_control.h instead of /usr/include/i386/fpu_control.h

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


