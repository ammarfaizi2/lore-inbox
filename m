Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135251AbRDRSbm>; Wed, 18 Apr 2001 14:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135247AbRDRSbc>; Wed, 18 Apr 2001 14:31:32 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:20200 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S132507AbRDRSbP>; Wed, 18 Apr 2001 14:31:15 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDD9A@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Let init know user wants to shutdown
Date: Wed, 18 Apr 2001 11:28:52 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Simon Richter
> > We are going to need some software that handles button 
> events, as well as
> > thermal events, battery events, polling the battery, AC 
> adapter status
> > changes, sleeping the system, and more.
> 
> Yes, that will be a separate daemon that will also get the 
> events. But I
> think it's a good idea to have a simple interface that allows 
> the user to
> run arbitrary commands when ACPI events occur, even without 
> acpid running
> (think of singleuser mode, embedded systems, ...).

Fair enough. I don't think I would be out of line to say that our resources
are focused on enabling full ACPI functionality for Linux, including a
full-featured PM policy daemon. That said, I don't think there's anything
precluding the use of another daemon (or whatever) from using the ACPI
driver's interface.

> > Unix philosophy: "do one thing and do it well".
> 
> Another Unix philosophy: "keep it simple, stupid". :-)

OK one more silly aphorism and I'll shut up. ;-) "Make it as simple as
possible, but no simpler."

Regards -- Andy

