Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSBCODK>; Sun, 3 Feb 2002 09:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287212AbSBCODA>; Sun, 3 Feb 2002 09:03:00 -0500
Received: from ns.suse.de ([213.95.15.193]:43787 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287208AbSBCOCw>;
	Sun, 3 Feb 2002 09:02:52 -0500
Date: Sun, 3 Feb 2002 15:02:50 +0100
From: Dave Jones <davej@suse.de>
To: Nathan <wfilardo@fuse.net>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
        vojtech@suse.cz
Subject: Re: Issues with 2.5.3-dj1
Message-ID: <20020203150250.A24149@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nathan <wfilardo@fuse.net>, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <3C5B5EC0.40503@fuse.net> <20020202055115.GA11359@kroah.com> <3C5B8C0D.8090009@fuse.net> <20020202133358.A5738@suse.de> <3C5C8CA2.9000103@fuse.net> <20020203062124.GA15134@kroah.com> <3C5CD8FD.6@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5CD8FD.6@fuse.net>; from wfilardo@fuse.net on Sun, Feb 03, 2002 at 01:30:21AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2002 at 01:30:21AM -0500, Nathan wrote:

 > >>w/ Greg's USB driverfs patch : system proves to be stable.
 > >>   (though 2.5.3 sometimes looses my keyboard after a time?)
 > >Is this a USB keyboard?  Are there any kernel log messages?
 > It's a regular AT keyboard... no, there are no kernel log messages 
 > dumped to the screen and I highly doubt any captured to any file because 
 > the only way out is to power down the system.  Searching kern.log, all I 
 > see is hotplug add NAME=AT commands, which is nothing unusual.  This 
 > "losing" only seems to happen after 2.5.2-dj6 (did not try -dj7).
 > 
 > But even 2.5.2-dj6 will lose my mouse... or rather, it will never see it 
 > to begin with.  It's a regular, bland, boring PS/2 mouse.

 Strange. If you only see this in my tree (and not vanilla 2.5.x),
 then this is Vojtech's input changes. Probably some more twiddling
 needed to get it perfect.


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
