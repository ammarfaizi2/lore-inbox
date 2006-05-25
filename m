Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWEYUNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWEYUNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 16:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWEYUNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 16:13:49 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:9136 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751122AbWEYUNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 16:13:48 -0400
Date: Thu, 25 May 2006 16:13:47 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
Message-ID: <20060525201347.GA21926@csclub.uwaterloo.ca>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 08:40:59PM +0200, Jan Engelhardt wrote:
> # cat /proc/version
> Linux version 2.6.17-rc4 (jengelh@shanghai) (gcc version 4.1.0 (SUSE 
> Linux)) #1 Sat May 20 00:06:16 CEST 2006
> # hostname
> shanghai
> # hostname --fqdn
> shanghai.hopto.org
> # dnsdomainname
> hopto.org
> 
> If the FQDN was already in the kernel, I would not have submitted this.
> Frankly, the only that that I have not done was compile test it :)
>
> Oh in that case you just found a bug in suse linux.

And Debian too.  I thought it was invalid to put the FQDN as your
hostname.  Also makes updating the domain for a network harder (if one
would ever want to do so).  Putting the FQDN as my hostname, makes
hostname -f act very strange.  I think a number of tools think doing it
is wrong.

Len Sorensen
