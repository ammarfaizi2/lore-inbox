Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132821AbRDQTJg>; Tue, 17 Apr 2001 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132822AbRDQTJ0>; Tue, 17 Apr 2001 15:09:26 -0400
Received: from mail.gci.com ([205.140.80.57]:10766 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S132821AbRDQTJQ>;
	Tue, 17 Apr 2001 15:09:16 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446DA2E@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Ian.Stirling@tomcat.admin.navo.hpc.mil, root@mauve.demon.co.uk,
        linux-kernel@vger.kernel.org
Subject: RE: IP Acounting Idea for 2.5
Date: Tue, 17 Apr 2001 11:09:09 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard replies:
to Leif Sawyer who wrote: 
>> Besides, what would be gained in making the counters RO, if 
>> they were cleared every time the module was loaded/unloaded?
> 
> 1. Knowlege that the module was reloaded.
> 2. Knowlege that the data being measured is correct
> 3. Having reliable measures
> 4. being able to derive valid statistics
> ....

Good.  Now that we have valid objectives to reach, which of these
are NOT met by making the fixes entirely in userspace, say by
incorporating a wrapper script to ensure that no external applications
can flush the table counters?

They're still all met, right?

And we haven't had to fill the kernel with more cruft.

