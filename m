Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268174AbRG2VXn>; Sun, 29 Jul 2001 17:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268184AbRG2VXd>; Sun, 29 Jul 2001 17:23:33 -0400
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:19182 "HELO
	duron.intern.kubla.de") by vger.kernel.org with SMTP
	id <S268174AbRG2VX0>; Sun, 29 Jul 2001 17:23:26 -0400
Date: Sun, 29 Jul 2001 23:23:22 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Debian-Devel List <debian-devel@lists.debian.org>,
        Jean Charles Delepine <delepine@u-picardie.fr>,
        Herbert Xu <herbert@debian.org>,
        Manoj Srivastava <srivasta@debian.org>
Subject: Re: make rpm
Message-ID: <20010729232322.F873@intern.kubla.de>
In-Reply-To: <20010730004916.A2359@broken.wedontsleep.org> <20010729172630.A22503@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010729172630.A22503@wiggy.net>
User-Agent: Mutt/1.3.18i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 29, 2001 at 05:26:30PM +0200, Wichert Akkerman wrote:
> Previously Steve Kowalik wrote:
> > make-kpkg --revision=${KERNELRELEASE} kernel_image",surely?
> 
> No, the package revision is completely seperate from the kernel
> release version.
> 
> Wichert.

Perhaps one should use:
	make-kpkg --revision=$(shell cat .version) kernel_image

Like the "Build" number used by a certain software from Redmond, WA.

Dominik
-- 
ScioByte GmbH, Zum Schiersteiner Grund 2, 55127 Mainz (Germany)
Phone: +49 6131 550 117  Fax: +49 6131 610 99 16

GnuPG: 717F16BB / A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
