Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVAaCek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVAaCek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 21:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVAaCek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 21:34:40 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:39605 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261897AbVAaCeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 21:34:37 -0500
Subject: Re: OpenOffice crashes due to incorrect access permissions on
	/dev/dri/card*
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, ee21rh@surrey.ac.uk
In-Reply-To: <1107028644.5718.3.camel@localhost.localdomain>
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
	 <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
	 <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
	 <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
	 <9e473391050129112525f4947@mail.gmail.com>
	 <1107028644.5718.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 30 Jan 2005 19:34:30 -0700
Message-Id: <1107138870.3398.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.4 (2.1.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My problem is some things changed in the installed package changed and
some things in my home directory in .openoffice (setup and soffice) were
incorrect. I erased the symlinks and my problem is over.  I would
suggest others having problems try the same. This may have NOTHING to do
with the kernel (as in my case).

Trever

On Sat, 2005-01-29 at 12:57 -0700, Trever L. Adams wrote:
> For the record, this has nothing to do with my crash. Mine still crashes
> all the time if I try to save a new document.
> 
> Trever
> 
> On Sat, 2005-01-29 at 14:25 -0500, Jon Smirl wrote:
> > On Sat, 29 Jan 2005 13:02:51 +0000, Richard Hughes <ee21rh@surrey.ac.uk> wrote:
> > > On Sat, 29 Jan 2005 12:49:16 +0000, Richard Hughes wrote:
> > > > Note, that strace glxgears gives exactly the same output, going from 0 to
> > > > 14 and then seg-faulting, so it's *not just a oo problem*.
> > > 
> > > I know it's bad to answer your own post, but here goes.
> > > 
> > > I changed my /etc/udev/permissions.d/50-udev.permissions config to read:
> > > 
> > > dri/*:root:root:0666
> > > 
> > > changing it from
> > > 
> > > dri/*:root:root:0660
> > > 
> > > And oowriter and glxgears work from bootup. Shall I file a bug with udev?
> > 
> > Your user ID needs to belong to group DRI.
> > 
> --
> Legal Warning: Anyone sending me unsolicited/commercial email WILL be
> charged a $100 proof-reading fee. See US Code Title 47,
> Sec.227(a)(2)(B), Sec.227(b)(1)(C) and Sec.227(b)(3)(C).
--
"The Master doesn't talk, he acts. When his work is done, the people
say, 'Amazing: we did it, all by ourselves!'" -- Lao-tzu

