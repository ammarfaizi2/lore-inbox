Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317332AbSFLWAu>; Wed, 12 Jun 2002 18:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317336AbSFLWAt>; Wed, 12 Jun 2002 18:00:49 -0400
Received: from host.greatconnect.com ([209.239.40.135]:53518 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S317332AbSFLWAr>; Wed, 12 Jun 2002 18:00:47 -0400
Subject: RE: PROBLEM: Kernel 2.4.18 Promise driver (IDE) hangs @ boot
	withPromise 20267
From: Samuel Flory <sflory@rackable.com>
To: Braden McGrath <bwm3@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006f01c21258$b72a7430$ceaa1681@z>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jun 2002 08:00:22 -0700
Message-Id: <1023894033.31270.195.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-12 at 14:32, Braden McGrath wrote:
> >   You might try Alan Cox's ac kernel.  2.4.19pre10ac2 seems 
> > to work bit better on the Promise controllers for me.  You 
> > will need to patch in 2.4.19pre10, and then 2.4.19pre10ac2.
> > 
> > http://www.us.kernel.org/pub/linux/kernel/v2.4/testing/
> >
> http://www.us.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.19/
> 
> Thanks, I'll give it a try... Will I experience any problems trying to
> get XFS into this kernel as well?  I start with 2.4.18 to patch to the
> pre* series, correct?  (I'm not used to running bleeding edge...)  I'm
> guessing the order would be:
> 2.4.18 (stock)
> +XFS
> +.19pre10
> +pre10ac2
> 

  I doubt you are going to be able to apply the std xfs patch to
pre10ac2.  On the other hand if you grab xfs out of cvs you'll have
2.4.19pre10+xfs.  You might be able to produce a patch from that
(2.4.19pre10 -> 2.4.19pre10+xfs) applies fairly cleanly to pre10ac2. 
I'd check and see if 2.4.18-pre10ac2 even boots before trying that;-)

> CONFIG_PDC202XX_FORCE=n    (I read that this is for FastTrak
> controllers, I only have an Ultra100)

  Opps my bad.  I've got both the ultratraks, and fasttraks floating
around in various systems.


