Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbTGBECz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 00:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTGBECz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 00:02:55 -0400
Received: from H239-211.STATE.resnet.albany.edu ([169.226.239.211]:60057 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id S264678AbTGBECy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 00:02:54 -0400
Subject: Re: usb serial/visor oops in 2.4.22-pre2
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030702033246.GA3272@kroah.com>
References: <1057106020.22290.17.camel@s.bouncybouncy.net>
	 <20030702005724.GA2337@kroah.com>
	 <1057107790.22288.23.camel@s.bouncybouncy.net>
	 <20030702033246.GA3272@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057119450.22291.54.camel@s.bouncybouncy.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 02 Jul 2003 00:17:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 23:32, Greg KH wrote:
> Any reason for not sending this to linux-kernel too?

hmmm i think you mean the linux-usb list too?

> 
> On Tue, Jul 01, 2003 at 09:03:10PM -0400, Justin A wrote:
> > On Tue, 2003-07-01 at 20:57, Greg KH wrote:
> > > On Tue, Jul 01, 2003 at 08:33:40PM -0400, Justin A wrote:
> > > > basically, pilot-xfer and all don't work anymore, dmesg reports:
> > > 
> > > But 2.4.21 works just fine for you?
> > dunno, I went from 2.4.21-rc6 to 2.2.22-pre2
> > it sorta worked once or twice in 2.2.21-rc6, but then stopped working.
> 
> With the same oops?
yeah, that or it would just timeout but no oops.
The thing about the oops is that it happens when it times out after not
establishing a connecting, it's not that I hit the sync button and it
immediately oopses.

> > I had been out of batteries for a while, so I can't remember the last
> > kernel it worked perfectly with, but I think it was 2.4.21-pre5-ac3
> > 
> > If you want I'll test a specific config.
> > > What USB host driver are you using?
> > uhci
> 
> Can you try usb-uhci and see if it works better?
I am using usb-uhci.. forgot there was a driver named just 'uhci' :)
> thanks,
> 
> greg k-h

I will reboot tomorrow when I get a chance, and verify that it still
works on my old kernels and if it does try with 2.4.21.

I wouldn't be surprised if the heat killed it or something.

-- 
Justin A <justin@bouncybouncy.net>
