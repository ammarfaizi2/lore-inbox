Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133005AbRD2XkX>; Sun, 29 Apr 2001 19:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132993AbRD2XkM>; Sun, 29 Apr 2001 19:40:12 -0400
Received: from p3EE3C784.dip.t-dialin.net ([62.227.199.132]:23301 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S132999AbRD2Xj7>; Sun, 29 Apr 2001 19:39:59 -0400
Date: Mon, 30 Apr 2001 01:39:56 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010430013956.A1578@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010428202225.D11994@emma1.emma.line.org> <PGEDKPCOHCLFJBPJPLNMCEDICMAA.denali@sunflower.com> <20010429122546.A1419@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010429122546.A1419@werewolf.able.es>; from jamagallon@able.es on Sun, Apr 29, 2001 at 12:25:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2001, J . A . Magallon wrote:

> >              Command found on device queue
> > aic7xxx_abort returns 8194
> 
> I have seen blaming for this error to aic7xxx new driver prior to version
> 6.1.11. It was included in the 2.4.3-ac series, but its has not got into
> main 2.4.4 (there is still 6.1.5). Everything needs its time.

Since the official aic7xxx site doesn't carry a patch against 2.4.4 yet
(just 2.4.3) which has cosmetic issues when being patched, I made a
patch against 2.4.4: I took the 2.4.3-aic7xxx-6.1.12 patch, applied to
2.4.4, bumped the version to read -ma1 in EXTRAVERSION, and made a new
patch against vanilla 2.4.4, to be found at:

*** WARNING BELOW ***

http://mandree.home.pages.de/kernelpatches/v2.4/v2.4.4/
 72k linux-2.4.4-aic7xxx-to-6.1.12.patch.gz

Apply with patch -p1.

NOTE: Do not expect this patch to last until after either Justin has a
patch against 2.4.4 available or 2.4.5 has been released.

*** WARNING *** I did not yet try to boot it, that will have to wait
until later.
