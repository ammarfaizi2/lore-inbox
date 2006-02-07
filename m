Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWBGAqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWBGAqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBGAqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:46:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29837 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964902AbWBGAqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:46:32 -0500
Date: Tue, 7 Feb 2006 01:46:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <nigel@suspend2.net>,
       suspend2-devel@lists.suspend2.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207004611.GD1575@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139251682.2791.290.camel@mindpipe> <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl> <20060207003713.GB31153@voodoo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207003713.GB31153@voodoo>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-02-06 19:37:13, Jim Crilly wrote:
> On 02/07/06 12:51:40AM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This point is valid, but I don't think the users will _have_ _to_ switch to the
> > userland suspend.  AFAICT we are going to keep the kernel-based code
> > as long as necessary.
> > 
> > We are just going to implement features in the user space that need not be
> > implemented in the kernel.  Of course they can be implemented in the
> > kernel, and you have shown that clearly, but since they need not be there,
> > we should at least try to implement them in the user space and see how this
> > works.
> > 
> > Frankly, I have no strong opinion on whether they _should_ be implemented
> > in the user space or in the kernel, but I think we won't know that until
> > we actually _try_.
> > 
> 
> Some of the stuff belongs in userspace without a doubt, like the UI. But
> why was the cryptoapi stuff added to the kernel if everytime someone goes
> to use it people yell "That's too much complexity, do it in userspace!"?

For stuff that can't be reasonably done in userspace, like encrypted
loop. And notice that cryptoapi does *not* yet contain LZW.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
