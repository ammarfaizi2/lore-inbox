Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbQJ0VGP>; Fri, 27 Oct 2000 17:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbQJ0VGF>; Fri, 27 Oct 2000 17:06:05 -0400
Received: from zeus.kernel.org ([209.10.41.242]:38151 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130383AbQJ0VF5>;
	Fri, 27 Oct 2000 17:05:57 -0400
Date: Sat, 28 Oct 2000 00:10:03 +0200 (CEST)
From: Igmar Palsenberg <maillist@chello.nl>
To: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-gcc@vger.kernel.org,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
In-Reply-To: <s5gy9zbzkz3.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.21.0010280008530.12608-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is not an option for us, unfortunately.  Many of our IP addresses
> are dynamically assigned, with the DNS tables dynamically updated.

Not an option in that case.
 
> Thank you for the patch to syslogd, though!  Can you try to get your
> "-x" option into the standard distributions of syslogd, or should I
> work up a bug report / feature request for Red Hat myself?

I have no idea who officially maintains it.. putting a bug report with RH
should be a good idea. The patch is untested, so someone needs to verify
that remote logging indeed nog is IP only. 

>  - Pat
> 

	
	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
