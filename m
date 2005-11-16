Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbVKPXQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbVKPXQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbVKPXQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:16:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:64916 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030565AbVKPXQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:16:50 -0500
Subject: Re: [PATCH] ppc64: 64K pages support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <20051116230820.GA29068@suse.de>
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de>
	 <20051109201720.GB5443@w-mikek2.ibm.com> <1131568336.24637.91.camel@gaston>
	 <1131573556.25354.1.camel@localhost.localdomain>
	 <1131573693.24637.109.camel@gaston>
	 <1131574051.25354.3.camel@localhost.localdomain>
	 <20051116230820.GA29068@suse.de>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 15:16:42 -0800
Message-Id: <1132183002.24066.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 00:08 +0100, Olaf Hering wrote:
>  On Wed, Nov 09, Badari Pulavarty wrote:
> 
> > On Thu, 2005-11-10 at 09:01 +1100, Benjamin Herrenschmidt wrote:
> > > > I didn't have any luck on 2.6.14-git12 either.
> > > > I tried 64k page support on my P570. 
> > > > 
> > > > Here are the console messages:
> > > 
> > > What distro do you use in userland ? Some older glibc versions have a
> > > bug that cause issues with 64k pages, though it generally happens with
> > > login blowing up, not init ...
> > 
> > SLES9 (could be SLES9 SP1).
> 
> Can you double check? rpm -qi glibc | head should be enough.
> Would be bad if SP2 or SP3 does not work with 64k.
> 

I think I am using SLES9. Planning to update to SP3.

# rpm -qi glibc | head
Name        : glibc                        Relocations: (not
relocatable)
Version     : 2.3.3                             Vendor: SuSE Linux AG,
Nuernberg, Germany
Release     : 98.28                         Build Date: Wed Jun 30
15:55:45 2004
Install date: Wed Jul  6 17:24:44 2005      Build Host:
gooseberry.suse.de
Group       : System/Libraries              Source RPM:
glibc-2.3.3-98.28.src.rpm
Size        : 6161800                          License: GPL, LGPL
Signature   : DSA/SHA1, Wed Jun 30 16:00:21 2004, Key ID
a84edae89c800aca
Packager    : http://www.suse.de/feedback
URL         : http://www.gnu.org/software/libc/libc.html
Summary     : The standard shared libraries (from the GNU C Library)

Thanks,
Badari

