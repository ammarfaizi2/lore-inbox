Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272988AbTGaLK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272989AbTGaLK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:10:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6785 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272988AbTGaLKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:10:23 -0400
Date: Thu, 31 Jul 2003 07:11:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
In-Reply-To: <1059606259.10505.20.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0307310709150.3917@chaos>
References: <20030730135623.GA1873@lug-owl.de>  <20030730181006.GB21734@fs.tum.de>
 <20030730183033.GA970@matchmail.com>  <20030730184529.GE21734@fs.tum.de> 
 <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>  <20030730203318.GH1873@lug-owl.de>
 <1059606259.10505.20.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2003, Alan Cox wrote:

> On Mer, 2003-07-30 at 21:33, Jan-Benedict Glaw wrote:
> > Well... For sure, I can write a LD_PRELOAD lib dealing with SIGILL, but
> > how do I enable it for the whole system. That is, I'd need to give
> > LD_PRELOAD=xxx at the kernel's boot prompt to have it as en environment
> > variable for each and every process?
>
>
> /etc/ld.preload
>
> > That sounds a tad inelegant to me. Really, I'd prefer to see libstdc++
> > be compiled for i386 ...
>
> True
>

What is a runtime library doing with a TSC? That's the basic problem.
These things are for operating systems and, last time I checked, the
'C' runtime libraries weren't (but maybe GNU changed that definition, no?)


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

