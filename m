Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUE0SBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUE0SBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUE0SBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:01:20 -0400
Received: from host171.155.212.251.conversent.net ([155.212.251.171]:21455
	"EHLO actuality-systems.com") by vger.kernel.org with ESMTP
	id S264910AbUE0SBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:01:18 -0400
Subject: Re: Can't make XFS work with 2.6.6
From: David Aubin <daubin@actuality-systems.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200405271854.20787.dj@david-web.co.uk>
References: <200405271736.08288.dj@david-web.co.uk>
	 <1085676905.5311.33.camel@buffy>  <200405271854.20787.dj@david-web.co.uk>
Content-Type: text/plain
Message-Id: <1085680806.5311.44.camel@buffy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 27 May 2004 14:00:06 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2004 17:59:49.0093 (UTC) FILETIME=[66FA4950:01C44414]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

  Please include the latest copy of your .config.
Also the boot loader parameter as well.  And possibly
the validation that the root partition is of type XFS?

  At a glance it appears that XFS is not compilied in to
your kernel now, if that is your root mount file type.

Thanks,
Dave

On Thu, 2004-05-27 at 13:54, David Johnson wrote:
> On Thursday 27 May 2004 17:55, David Aubin wrote:
> > Your ide support is compiled as a module.  If you are not calling out
> > the module
> > in your initrc, then you will get this.  Go back and compile in your ide
> > support
> > or scsi support as compiled in options.  Both are currently built as
> > modules.
> >
> 
> OK, I recompiled with the IDE compiled in, but it didn't make much 
> difference :-(
> The error is the same except for: -
> 
> Instead of:
> Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> I get:
> Kernel Panic: VFS: Unable to mount root fs on hda3
> 
> Thanks for your help so far,
> David.

