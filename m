Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVFCUoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVFCUoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 16:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVFCUoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 16:44:09 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:8590 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261357AbVFCUoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 16:44:05 -0400
Date: Fri, 3 Jun 2005 16:44:05 -0400
To: Anil kumar <anils_r@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: install athlon rpm on amd64
Message-ID: <20050603204405.GQ23621@csclub.uwaterloo.ca>
References: <20050603203032.89634.qmail@web32402.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603203032.89634.qmail@web32402.mail.mud.yahoo.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 01:30:32PM -0700, Anil kumar wrote:
> Can I install an athlon(amd32) rpm on an amd64(x86_64)
> machine.
> When I tried installing, I am getting an ELF file
> incompatibility. The .obj file in the athlon rpm is
> ELF-32bit but the system is x86_64.
> I guess it should still work? 

Probably not.  x86_64 can emulate / run 32bit environment, and run 32bit
programs assuming you have all the required 32bit libraries.  That
doesn't mean rpm has to know about that.  I don't know how redhat
handles x86_64, but certainly Debian does not accept a 32bit package to
be installed by the 64bit package manager.  You can however setup a
chroot and run a 32bit environment in the chroot seperate from the 64bit
to manage software installs, and then run the program from outside the
chroot afterwards.  At least on Debian.

> Maybe my rpm is bad.

Highly unlikely.

> If not, can I install an athlon(amd32) rpm on an i386
> machine?

Using a 32bit rpm installer I imagine.

> My apologies if this is not the right mailing list for
> this type of question. 

A redhat list would be more likely to know.  It's not a kernel problem,
but an rpm user space problem.

Len Sorensen
