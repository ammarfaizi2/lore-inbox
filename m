Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSF1NS0>; Fri, 28 Jun 2002 09:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317219AbSF1NSZ>; Fri, 28 Jun 2002 09:18:25 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:38937 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S317217AbSF1NSY>; Fri, 28 Jun 2002 09:18:24 -0400
Date: Fri, 28 Jun 2002 08:20:13 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206281320.IAA77178@tomcat.admin.navo.hpc.mil>
To: chris@wirex.com, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Status of capabilities?
Cc: dax@gurulabs.com, Michael Kerrisk <m.kerrisk@gmx.net>,
       linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chris@wirex.com>:
> * Jesse Pollard (pollard@tomcat.admin.navo.hpc.mil) wrote:
> > 
> > Actually, I think most of that work has already been done by the Linux
> > Security Module project (well, except #7).
> 
> The LSM project supports capabilities exactly as it appears in the
> kernel right now.  The EA linkage is still missing.  Of course, we are
> accepting patches ;-)

Absolutely - I was just meaning that the effort of identifing the location(s)
in the kernel the hooks will have to be to set the capabilities from the EA
reference has been done. And in a central location too. Also, the hooks in the
filesystem will provide the location, if not access to, the EA when they
become available in/to the VFS (at least I hope that's where they end up).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
