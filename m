Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUITUdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUITUdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUITUde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:33:34 -0400
Received: from main.gmane.org ([80.91.229.2]:17038 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267344AbUITUaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:30:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Linux 2.6.9-rc2 (compile stats)
Date: Mon, 20 Sep 2004 22:23:19 +0200
Message-ID: <MPG.1bb95958863740f59896f3@news.gmane.org>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org> <1095700064.2867.30.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-194-140.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > The one thing that people may actually _notice_ is that you get a lot more 
> > warnings for some drivers due to the stricter type-checks for PCI memory 
> > mapping. They are harmless (code generation should be the same), and we'll 
> > work on trying to fix up the drivers as we go along, but they can be a bit 
> > daunting if you happen to enable some of the less type-friendly drivers 
> > right now..

John Cherry wrote:
> Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
>              (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
> -----------  -----------  -------- -------- -------- -------- ---------
> 2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
> 2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e

Jeepers! Talk about 'daunting' ... :)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

