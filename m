Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbVKPXI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbVKPXI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbVKPXI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:08:27 -0500
Received: from ns1.suse.de ([195.135.220.2]:41887 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030572AbVKPXI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:08:26 -0500
Date: Thu, 17 Nov 2005 00:08:20 +0100
From: Olaf Hering <olh@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] ppc64: 64K pages support
Message-ID: <20051116230820.GA29068@suse.de>
References: <1130915220.20136.14.camel@gaston> <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de> <20051109201720.GB5443@w-mikek2.ibm.com> <1131568336.24637.91.camel@gaston> <1131573556.25354.1.camel@localhost.localdomain> <1131573693.24637.109.camel@gaston> <1131574051.25354.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1131574051.25354.3.camel@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Nov 09, Badari Pulavarty wrote:

> On Thu, 2005-11-10 at 09:01 +1100, Benjamin Herrenschmidt wrote:
> > > I didn't have any luck on 2.6.14-git12 either.
> > > I tried 64k page support on my P570. 
> > > 
> > > Here are the console messages:
> > 
> > What distro do you use in userland ? Some older glibc versions have a
> > bug that cause issues with 64k pages, though it generally happens with
> > login blowing up, not init ...
> 
> SLES9 (could be SLES9 SP1).

Can you double check? rpm -qi glibc | head should be enough.
Would be bad if SP2 or SP3 does not work with 64k.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
