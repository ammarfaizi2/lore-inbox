Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVDEEvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVDEEvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 00:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVDEEvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 00:51:20 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:27239 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261558AbVDEEvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 00:51:18 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
Date: Mon, 4 Apr 2005 23:51:21 -0500
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>, Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <20050404191745.GB12141@kroah.com> <20050405042329.GA10171@delft.aura.cs.cmu.edu>
In-Reply-To: <20050405042329.GA10171@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504042351.22099.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 April 2005 23:23, Jan Harkes wrote:
> On Mon, Apr 04, 2005 at 12:17:46PM -0700, Greg KH wrote:
> > On Mon, Apr 04, 2005 at 08:27:53PM +0200, Sven Luther wrote:
> > > Mmm, probably that 2001 discussion about the keyspan firmware, right ?
> > > 
> > >   http://lists.debian.org/debian-legal/2001/04/msg00145.html
> > > 
> > > Can you summarize the conclusion of the thread, or what you did get from it,
> > > please ? 
> > 
> > That people didn't like the inclusion of firmware, I posted how you can
> > fix it by moving it outside of the kernel, and asked for patches.
> > 
> > None have come.
> 
> Didn't know you were waiting for it. How about something like the
> following series of patches?
> 
> [01/04] - add simple Intel IHEX format parser to the firmware loader.

Firmware loader is format-agnostic, I think having IHEX parser in a separate
file would be better...

-- 
Dmitry
