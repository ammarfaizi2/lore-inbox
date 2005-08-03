Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVHCJR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVHCJR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVHCJPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:15:25 -0400
Received: from mx5.mailserveren.com ([213.236.237.251]:2222 "EHLO
	mx5.mailserveren.com") by vger.kernel.org with ESMTP
	id S262174AbVHCJNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:13:45 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Hans Kristian Rosbach <hans.kristian@isphuset.no>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: "Theodore Ts'o" <tytso@mit.edu>, David Weinehall <tao@acc.umu.se>,
       Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <42EEFB9B.10508@andrew.cmu.edu>
References: <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>
	 <1122852234.13000.27.camel@mindpipe>
	 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
	 <20050801204245.GC17258@thunk.org>  <42EEFB9B.10508@andrew.cmu.edu>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Date: Wed, 03 Aug 2005 11:19:50 +0200
Message-Id: <1123060790.29553.7.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 00:50 -0400, James Bruce wrote:
> Theodore Ts'o wrote:
>  > On Mon, Aug 01, 2005 at 12:18:18PM -0400, James Bruce wrote:
>  >>The tradeoff is a realistic 4.4% power savings vs a 300% increase in
>  >>the minimum sleep period.  A user will see zero power savings if they
>  >>have a USB mouse (probably 99% of desktops).  On top of that, we can
>                                      ^^^^^^^^
> 
>  > Most laptops (including mine, a Thinkpad T40) use a PS/2 mouse.  So in
>  > the places where power consumption savins matters most, it's usually
>  > quite possible to function without needing any USB devices.  The 90%
>  > figure isn't at all right; in fact, it may be that over 90% of the
>  > laptops still use PS/2 mice and keyboards.
> 
> Yes, laptops are mostly PS/2, which is why I only claimed a statistic 
> for desktops.  Desktops pretty much all use USB mice now.  If 250Hz were 
> only being sold as an option for laptops, we could leave it at that, yet 
> its being pushed as a default that's "good for everyone".  For desktops 
> this is not currently true at all.  By the time USB is fixed to do power 
> saving, we'll probably have a working tick-skipping patch which makes 
> the whole HZ argument moot.

Most new laptops are moving away from PS/2 ports, for example my
shining (literally) new Acer Ferrari 4005 only has USB2 ports for mice
and keyboard inputs (unless in the optional pcie docking station maybe).
So my suggestion would be to fix USB power management.

The mouse that comes with the ferrari 4005 is actually a bluetooth
mouse, but for some reason it is the worst thing I've ever used.

So, what I'm currently using is a usb -> ps/2 converter. I can't imagine
this to be any good for power consumption at all.

(OT:Bad mouse)
-It will overcharge battery so the whole mouse becomes HOT
-Occasionally it will stop working for ~5sec
-The optical sensor takes a while to focus on the pad when lifted and
 put down again.

BTW: The laptop itself is _really_ good, just the mouse is a total
     failure.

-HK

