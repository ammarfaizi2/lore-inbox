Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268524AbTBODCI>; Fri, 14 Feb 2003 22:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268526AbTBODCI>; Fri, 14 Feb 2003 22:02:08 -0500
Received: from fmr01.intel.com ([192.55.52.18]:52683 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268524AbTBODCH>;
	Fri, 14 Feb 2003 22:02:07 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACB44@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Joel Becker'" <Joel.Becker@oracle.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Lynch <rusty@linux.co.intel.com>, Matt Porter <porter@cox.net>,
       Scott Murray <scottm@somanetworks.com>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][RFC] Proposal for a new watchdog interface using sysf
	s
Date: Fri, 14 Feb 2003 19:11:58 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Feb 14, 2003 at 05:55:53PM +0000, Alan Cox wrote:
> > think you need to care about that for now. Sysfs doesn't 
> help here in
> > the general case as it lacks persistant file permissions, 
> but where it
> 
> 	Oh, junk.  I liked this proposal a lot, but lack of persistent
> permissions kills it pretty dead.

If by persistant you mean across reboots, you can do what devfs did; at
shutdown, save the ones that change; at init, restore them -- some to
sensible defaults, plus the saved changes. That's user space policy.

Or am I missing anything?

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

