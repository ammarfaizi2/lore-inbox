Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTKNTeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTKNTeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:34:19 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:28350 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id S264374AbTKNTeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:34:17 -0500
Subject: Changes between 2.4.21 and 2.4.22-pre1 affecting filesystem mounts?
From: Nathan Neulinger <nneul@umr.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1068831962.2668.5.camel@infinity.cc.umr.edu>
References: <1068817830.30727.12.camel@cessna>
	 <1068831962.2668.5.camel@infinity.cc.umr.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: UMR Information Technology
Message-Id: <1068838455.2770.7.camel@infinity.cc.umr.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 14 Nov 2003 13:34:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the resend if you've already seen this, I had addr wrong...
Any ideas?

On Fri, 2003-11-14 at 11:46, Nathan Neulinger wrote:
> Narrowed this down to it breaking between 2.4.21 release and
> 2.4.22-pre1. (2.4.21 works fine, 22-pre1 does not.) I read over the
> detailed 2.4.22 ChangeLog and sure don't see anything that jumps out at
> me as a likely cause... Any ideas?
> 
> Basically, client looks like it starts up just fine, but there's nothing
> there. /afs is definately mounted, but the mount is non-functional and
> complains about not being a directory. 
> 
> -- Nathan
> 
> On Fri, 2003-11-14 at 07:50, Nathan Neulinger wrote:
> > I haven't dug into this in depth yet, but figured I'd ask in case the
> > answer was obvious to any kernel developers - tried updating to
> > 2.4.23-rc1 w/ openafs, and the filesystem mounts, but every traversal
> > attempt results in ENOTDIR. Is there something that changed in kernel
> > structures/functions/interfaces that needs to be addressed in openafs
> > src to fix this? Pointers to change info appreciated. 
> > 
> > -- Nathan
> > 
> > ------------------------------------------------------------
> > Nathan Neulinger                       EMail:  nneul@umr.edu
> > University of Missouri - Rolla         Phone: (573) 341-4841
> > UMR Information Technology             Fax: (573) 341-4216
-- 

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-6679
UMR Information Technology             Fax: (573) 341-4216
