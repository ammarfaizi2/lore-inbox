Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131777AbRC1ORJ>; Wed, 28 Mar 2001 09:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131830AbRC1OQ6>; Wed, 28 Mar 2001 09:16:58 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:30793 "EHLO tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP id <S131777AbRC1OQu>; Wed, 28 Mar 2001 09:16:50 -0500
Date: Wed, 28 Mar 2001 08:15:57 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103281415.IAA47715@tomcat.admin.navo.hpc.mil>
To: kaos@ocs.com.au, jesse@cats-chateau.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news.. 
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>
> 
> On Wed, 28 Mar 2001 06:08:15 -0600, 
> Jesse Pollard <jesse@cats-chateau.net> wrote:
> >Sure - very simple. If the execute bit is set on a file, don't allow
> >ANY write to the file. This does modify the permission bits slightly
> >but I don't think it is an unreasonable thing to have.
> 
> man strip
> man objcopy
> man ld

Thought of theses already (well, at least ld...)

strip - not used that much (most executables still have their symbol table
	but could be handled by removing the execute bit, stripping, then
	putting it back. Or just use the ld option -s.
objcopy - copies object files. Object files are not marked executable...
ld	- on other UNIX systems (Cray/IRIX), I think the output file
	(-o) specified is first deleted. Whenever I can cause a link
	error, the output is not marked executable. If the GNU ld doesn't
	delete it first, then it most likely should.

I was expecting shell scripts to be the complaint first... :-)

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
