Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271362AbTHHGxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTHHGxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:53:46 -0400
Received: from h211n2fls22o908.bredband.comhem.se ([81.224.85.211]:35261 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id S271362AbTHHGxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:53:44 -0400
Date: Fri, 8 Aug 2003 08:53:25 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: Frank Cusack <fcusack@fcusack.com>
cc: =?iso-8859-1?Q?Mathias_Fr=F6hlich?= <Mathias.Froehlich@web.de>,
       Jerry Cooperstein <coop@axian.com>, <linux-kernel@vger.kernel.org>,
       Luke Howard <lukeh@PADL.COM>
Subject: Re: NPTL v userland v LT (RH9+custom kernel problem)
In-Reply-To: <20030807224545.A29285@google.com>
Message-ID: <Pine.LNX.4.44.0308080850280.1466-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Frank Cusack wrote:

> On Thu, Aug 07, 2003 at 09:42:36AM -0500, Jerry Cooperstein wrote:
> > If you read the release notes for RH9 you'll see you can adjust what
> > thread library gets used with the environmental variable
> > LD_ASSUME_KERNEL.  So for instance you can do:
> > 
> > LD_ASSUME_KERNEL=2.2.5 rpm ....
> > LD_ASSUME_KERNEL=2.2.5 up2date 
> > 
> > (I've mentioned these two because I've noted these fail when you are
> > root...)
> 
> Interesting.  Something these have in common is that they all use
> Berkeley db4 (up2date by virtue of using rpm).  I don't understand why
> nss_ldap or pam_ldap would, but it's one of the sources in the srpm.

I have had rpm lock up on me a few times. I think it was waiting on a 
sempahore or some other synchronization event. After killing the process 
(after several hours) no rpm transactions could be completed, they all 
hanged at the same point. The only way to get rpm to work again was to 
reboot the system. 

Not sure if it is related or not though. I never thought to try it as 
non-root.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


