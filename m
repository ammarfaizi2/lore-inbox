Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131953AbRC1Pwm>; Wed, 28 Mar 2001 10:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131974AbRC1Pwd>; Wed, 28 Mar 2001 10:52:33 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:7498 "EHLO tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP id <S131953AbRC1Pw2>; Wed, 28 Mar 2001 10:52:28 -0500
Date: Wed, 28 Mar 2001 09:51:39 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103281551.JAA49453@tomcat.admin.navo.hpc.mil>
To: rmk@arm.linux.org.uk, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Disturbing news..
Cc: snwahofm@mi.uni-erlangen.de, Jesse Pollard <jesse@cats-chateau.net>, Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk>
> 
> On Wed, Mar 28, 2001 at 08:40:42AM -0600, Jesse Pollard wrote:
> > Now, if ELF were to be modified, I'd just add a segment checksum
> > for each segment, then put the checksum in the ELF header as well as
> > in the/a segment header just to make things harder. At exec time a checksum
> > verify could (expensive) be done on each segment. A reduced level could be
> > done only on the data segment or text segment. This would at least force
> > the virus to completly read the file to regenerate the checksum.
> 
> Checksums don't help that much - virus writers would treat it as "part
> of the set of alterations that need to be made" and then the checksum
> becomes zero protection.
> 
 [ snip of good stuff ]
> Therefore, if you follow good easy system administration techniques, then
> you end up minimising the risk of getting:
> 
> 1. viruses
> 2. trojans
> 3. malicious users
> 
> cracking your system.  If you don't follow these techniques, then you're
> asking for lots of trouble, and no amount of checksumming/signing/etc
> will ever save you.

Absolutely true. The only help the checksumming etc stuff is good for is
detecting the fact afterward by external comparison.

I like MLS for the ability to catch ATTEMPTS to make unauthorized
modification.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
