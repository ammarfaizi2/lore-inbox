Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264885AbUE0Q6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264885AbUE0Q6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUE0Q6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:58:47 -0400
Received: from host171.155.212.251.conversent.net ([155.212.251.171]:40132
	"EHLO actuality-systems.com") by vger.kernel.org with ESMTP
	id S264885AbUE0Q6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:58:46 -0400
Subject: Re: Can't make XFS work with 2.6.6
From: David Aubin <daubin@actuality-systems.com>
To: David Johnson <dj@david-web.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1085676905.5311.33.camel@buffy>
References: <200405271736.08288.dj@david-web.co.uk>
	 <1085676905.5311.33.camel@buffy>
Content-Type: text/plain
Message-Id: <1085677053.5311.35.camel@buffy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 27 May 2004 12:57:34 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2004 16:57:16.0500 (UTC) FILETIME=[AA420940:01C4440B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-27 at 12:55, David Aubin wrote:
> Your ide support is compiled as a module.  If you are not calling out
> the module
> in your initrc, then you will get this.  Go back and compile in your
> ide support
> or scsi support as compiled in options.  Both are currently built as
> modules.
> 
> Dave Aubin
> 
> On Thu, 2004-05-27 at 12:36, David Johnson wrote: 
> > Hello,
> > 
> > I'm having a problem getting my system to boot with 2.6.6 and a XFS root 
> > filesystem. On boot it can't mount the root fs:
> > 
> > XFS: Bad magic number
> > XFS: SB validate failed
> > Kernel Panic: VFS: Unable to mount root fs on unknown-block(0,0)
> > 
> > XFS is compiled in so it's not a module problem. Google says this error is 
> > usually caused by passing the wrong root parameter to the kernel, but I'm 
> > definitely giving the right root device.
> > 
> > I can boot just fine with 2.4.25 using exactly the same boot options in Grub.
> > I attach my .config. I'd be very greatful for any help with this. I've tried 
> > recompiling with XFS as a module and checked my version of xfsprogs meets the 
> > requirements.
> > 
> > Thanks in advance,
> > David.

