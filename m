Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266103AbRGLMXz>; Thu, 12 Jul 2001 08:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266118AbRGLMXj>; Thu, 12 Jul 2001 08:23:39 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:28319 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S266103AbRGLMXc>; Thu, 12 Jul 2001 08:23:32 -0400
Date: Thu, 12 Jul 2001 07:23:06 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107121223.HAA53012@tomcat.admin.navo.hpc.mil>
To: ralf@uni-koblenz.de, Andreas Dilger <adilger@turbolinux.com>
Subject: Re: Switching Kernels without Rebooting?
Cc: "C. Slater" <cslater@wcnet.org>, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@uni-koblenz.de>:
> On Wed, Jul 11, 2001 at 05:44:45PM -0600, Andreas Dilger wrote:
> 
> > The best proposal I've heard so far was to use MOSIX to do live job
> > migration between machines, and then upgrade the kernel like normal.
> > In the end, it is the jobs that are running on the kernel, and not
> > the kernel or the individual machine that are the most important.  One
> > person pointed out that there is a single point of failure in the
> > MOSIX "stub" machine, which doesn't help you in the end (how do you
> > update the kernel there?).  If you can figure a way to enhance MOSIX
> > to allow migrating the MOSIX "stub" processes to another machine, you
> > will have solved your problem in a much easier way, IMHO.
> 
> Virtual machines a la VM are also nice for this.  Build a HA cluster from
> two VMs, then upgrade one after another.  All that's required is HA stuff
> as it already is available.

That isn't even the same problem.
First, processes do not survive the upgrade.
Second, the upgrade must still be compatable with the host OS.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
