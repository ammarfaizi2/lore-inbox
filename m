Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUIKDaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUIKDaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 23:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUIKDaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 23:30:22 -0400
Received: from host-63-144-52-41.concordhotels.com ([63.144.52.41]:3900 "EHLO
	080relay.CIS.CIS.com") by vger.kernel.org with ESMTP
	id S268069AbUIKDaU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 23:30:20 -0400
Subject: Re: radeon-pre-2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Dave Airlie <airlied@linux.ie>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409110137590.26651@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Fri, 10 Sep 2004 23:30:12 -0400
Message-Id: <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 01:50 +0100, Dave Airlie wrote:
> 
> Alan, I agree with how you want to proceed with this, and keep things
> stable, but anything short of a single card-specific driver looking after
> the registers and DMA queueing and locking is going to have deficiencies
> [...]

You're probably right, but it still doesn't follow that this driver must
include all the fbdev and DRM code as well. Both fbdev and the DRM could
use that driver, e.g., just like ide_cd and ide_disk use the IDE driver.


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
