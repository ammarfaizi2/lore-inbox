Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266594AbUBDUtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266536AbUBDUYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:24:23 -0500
Received: from mail.ddc-ny.com ([12.35.229.4]:26629 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S266515AbUBDUXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:23:07 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16F39@DDCNYNTD>
From: "Randazzo, Michael" <RANDAZZO@ddc-web.com>
To: "'Valdis.Kletnieks@vt.edu'" <Valdis.Kletnieks@vt.edu>,
       "Randazzo, Michael" <RANDAZZO@ddc-web.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.x POSIX Compliance/Conformance... 
Date: Wed, 4 Feb 2004 15:22:53 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok...I think I get it....

I can't use any of the posix functions in 
device drivers (modules).....is this correct?

M.

-----Original Message-----
From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu]
Sent: Wednesday, February 04, 2004 3:21 PM
To: Randazzo, Michael
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: Kernel 2.x POSIX Compliance/Conformance... 


On Wed, 04 Feb 2004 15:18:17 EST, "Randazzo, Michael" said:
> Where are the kernel calls defined for locks and semaphores?
> 
> How come the kernel headers don't define Posix.4 
> semaphores (_POSIX_SEMAPHROES) or Posix itself
> (_POSIX_VERSION is undefined)

Posix.4 and _POSIX_VERSION are for *userspace*

The kernel isn't userspace.
 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

