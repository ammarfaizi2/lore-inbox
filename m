Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVA2T5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVA2T5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVA2T5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:57:41 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:29377 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261546AbVA2T5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:57:37 -0500
Subject: Re: OpenOffice crashes due to incorrect access permissions on
	/dev/dri/card*
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ee21rh@surrey.ac.uk, linux-kernel@vger.kernel.org
In-Reply-To: <9e473391050129112525f4947@mail.gmail.com>
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
	 <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
	 <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
	 <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
	 <9e473391050129112525f4947@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 12:57:24 -0700
Message-Id: <1107028644.5718.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.4 (2.1.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the record, this has nothing to do with my crash. Mine still crashes
all the time if I try to save a new document.

Trever

On Sat, 2005-01-29 at 14:25 -0500, Jon Smirl wrote:
> On Sat, 29 Jan 2005 13:02:51 +0000, Richard Hughes <ee21rh@surrey.ac.uk> wrote:
> > On Sat, 29 Jan 2005 12:49:16 +0000, Richard Hughes wrote:
> > > Note, that strace glxgears gives exactly the same output, going from 0 to
> > > 14 and then seg-faulting, so it's *not just a oo problem*.
> > 
> > I know it's bad to answer your own post, but here goes.
> > 
> > I changed my /etc/udev/permissions.d/50-udev.permissions config to read:
> > 
> > dri/*:root:root:0666
> > 
> > changing it from
> > 
> > dri/*:root:root:0660
> > 
> > And oowriter and glxgears work from bootup. Shall I file a bug with udev?
> 
> Your user ID needs to belong to group DRI.
> 
--
Legal Warning: Anyone sending me unsolicited/commercial email WILL be
charged a $100 proof-reading fee. See US Code Title 47,
Sec.227(a)(2)(B), Sec.227(b)(1)(C) and Sec.227(b)(3)(C).

