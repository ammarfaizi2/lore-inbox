Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWBRUvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWBRUvR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 15:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWBRUvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 15:51:17 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:36235 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932155AbWBRUvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 15:51:15 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: kbuild: Section mismatch warnings
Date: Sat, 18 Feb 2006 12:32:13 -0800
User-Agent: KMail/1.7.1
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, Paul Bristow <paul@paulbristow.net>,
       mpm@selenic.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, dwmw2@infradead.org
References: <20060217214855.GA5563@mars.ravnborg.org> <200602171648.38003.david-b@pacbell.net> <20060218005713.GA11197@suse.de>
In-Reply-To: <20060218005713.GA11197@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602181232.13913.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 4:57 pm, Greg KH wrote:

> > > And if so, we should mark the bind functions __init also, to prevent
> > > this from being flagged in the future.
> > 
> > And the unbind functions __exit/__exit_p()?  Smaller runtime footprints
> > are good.  I don't like leaving the driver->init() method invalid, which
> > is I think why I didn't do that before, but saving space is the right
> > thing to do.
> 
> Ok, care to create a patch for these?

Done; the Ethernet driver had another patch pending in that area, which
I've also forwarded to you.

- Dave

