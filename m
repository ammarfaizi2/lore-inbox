Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271148AbTGPVyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271144AbTGPVyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:54:17 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:57260 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S271148AbTGPVyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:54:00 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>, Fredrik Tolf <fredrik@dolda2000.cjb.net>
Subject: Re: Input layer demand loading
Date: Thu, 17 Jul 2003 00:07:04 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <200307162323.31836.fredrik@dolda2000.cjb.net> <20030716215452.GB2773@kroah.com>
In-Reply-To: <20030716215452.GB2773@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307170007.04782.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Huh? Look at it this way: As it is now, if you have a non-hotplug joystick, 
> > then you can't load anything automatically, not even the hardware drivers.
> 
> Correct.
> 
> > If you have demand-loading in the input layer, on the other hand, you can have 
> > "above" directives in modules.conf (or "install" directives in modprobe.conf) 
> > to pull in the hardware drivers along with joydev.
> 
> Where do you get the hardware driver coming along with joydev?

By editing /etc/modules.conf
 
> I must be missing something here...

Yes, there are non hotpluggable devices out there.
It is easy to forget :-)
 
	Regards
		Oliver

