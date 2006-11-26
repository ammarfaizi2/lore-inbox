Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935320AbWKZKXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935320AbWKZKXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 05:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935321AbWKZKXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 05:23:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:44957 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S935320AbWKZKXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 05:23:12 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Date: Sun, 26 Nov 2006 11:13:12 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>
References: <fa.U3NcOE+DHLOUMSq6HkaGglGl7hQ@ifi.uio.no> <fa.bo0iOgKqELDD50VEZpxeUpzPsMg@ifi.uio.no> <45693E25.9010504@shaw.ca>
In-Reply-To: <45693E25.9010504@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611261113.12826.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 26 November 2006 08:11, Robert Hancock wrote:
> Alan wrote:
> > Lots of other controllers don't work correctly on resume but thats much
> > less of a problem and with UDMA misclocking generally turns into a CRC
> > error storm and stop.
> > 
> > Andrew has about 2/3rds of the bits I've done now, will push the rest
> > when I've done a little more testing/checking. At that point libata ought
> > to be resume safe. Someone who cares about drivers/ide legacy support can
> > then copy the work over.
> 
> btw, I have some code almost ready for sata_nv to add proper 
> suspend/resume support. Unfortunately I have trouble testing it, since 
> STR doesn't work on my machine since, guess what - the video doesn't 
> come back! It doesn't even take the monitor out of standby mode. None of 
> the acpi_sleep options seem to work, and vbetool appears to helpfully 
> segfault on any operation so that's out.

I guess it's x86-64?  Which version of vbetool?

> This is an NVIDIA SLI setup so that probably makes things a bit more
> complicated.

Ouch.

> In any case, it should be better than what we have right now for 
> suspend/resume support in sata_nv, namely the "do nothing, won't work 
> (at least not for CK804 and later)" implementation..

I think I can test it if you send me the patch.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
