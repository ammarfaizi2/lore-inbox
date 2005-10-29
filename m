Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVJ2O4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVJ2O4I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJ2O4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:56:08 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:61832 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751174AbVJ2O4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:56:07 -0400
Subject: Re: Intel D945GNT crashes with AGP enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1130597398.6786.10.camel@jetpack.demon.co.uk>
References: <1130506715.5345.7.camel@blade>
	 <20051028162806.GA4340@redhat.com>  <1130518160.5372.6.camel@blade>
	 <1130585267.5360.12.camel@blade>  <1130588872.24907.1.camel@blade>
	 <1130593470.6786.4.camel@jetpack.demon.co.uk>
	 <1130594110.5396.8.camel@blade>
	 <1130597398.6786.10.camel@jetpack.demon.co.uk>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 16:56:02 +0200
Message-Id: <1130597762.5396.18.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> > > You are barking up the wrong tree with this. Read the tristate line.
> > > 
> > > It doesn't mention 915 or 945 support. Intelfb only supports upto the
> > > 865G anyway.
> > 
> > I read that line and enabling the compilation of the intelfb on x86_64
> > was only a simple try to see if it compiles. It doesn't and basically I
> > have no idea how to fix it.
> > 
> > The 915G (8086:2582) is supported by the driver in the latest vanilla
> > kernel. Look at intelfb.h file and then you will see that the comment
> > line in Kconfig is outdated. I also found a patch to support the 915GM
> > (8086:2592) and maybe a similar patch will make the 945 work with the
> > intelfb driver.
> 
> Doing a quick google shows that support is only partial for 915G. And
> the 915GM patch would be easily done for the 945G.
> 
> But I'm not sure how partial that support is having not tried it, but I
> can see that there are definate problems here.

I can do the patch for the 945G by myself, but the current problem is
that the intelfb driver not even compiles on EM64T. Otherwise I would
give it a try and see if it helps me.

Regards

Marcel


