Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbVHZKhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbVHZKhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 06:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVHZKhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 06:37:42 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:22086 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751074AbVHZKhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 06:37:42 -0400
Date: Fri, 26 Aug 2005 12:37:40 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Alan Jenkins <sourcejedi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050826103740.GB28640@harddisk-recovery.com>
References: <1124996732.5848.9.camel@singularity.jenkins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124996732.5848.9.camel@singularity.jenkins>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 08:05:32PM +0100, Alan Jenkins wrote:
> > On Thu, Aug 25, 2005 at 12:32:50AM -0400, robo...@godmail.com wrote: 
> > > Right, but it would be nice to have that option if initramfs 
> > > using tmpfs becomes part of the kernel. 
> > 
> > But it's not needed so why add bloat? 
> 
> I'm not subscribed, so sorry if this doesn't fall into the original
> thread.  I'm curious as to why the kernel has to include the decoder -
> why you can't just run a self-extracting executable in an empty
> initramfs (with a preset capacity if needs be).

How would that help? It's still a decoder in the kernel, so why not use
one that's well tested instead of using whatever the archive thinks is
good?

Also remember the code has to be cross platform: an in-kernel decoder
will just work on any platform, a self-extracting binary will probably
only work on one platform.

Besides, initramfs was made to set up userland. A self-extracting
binary creates a chicken-and-egg problem: when run it will create a
userland, but in order to be run it needs a userland.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
