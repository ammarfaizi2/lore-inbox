Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTEYKBC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTEYKBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:01:02 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:41088 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261651AbTEYKBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:01:01 -0400
Date: Sun, 25 May 2003 12:19:24 +0100
From: john@grabjohn.com
Message-Id: <200305251119.h4PBJOal000678@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, rmk@arm.linux.org.uk
Subject: Re: [RFR] a new SCSI driver
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thinking ahead, by the 2.8 timescale, PATA could well be legacy hardware 
> > which could be supported only by an 'old' IDE driver, much like we already
> > have at the moment - I.E. we could remove the current 'old' IDE driver
> > sometime during the 2.7 timescale, and support SATA only via the SCSI layer.

> Rubbish.  PIO mode ATA will be around for some years to come - there
> is just too much invested there (especially in the embedded world) for 
> it to vanish this quickly.  For example, think about compact flash cards,
> many of which are still driven using PIO mode accesses in todays PDAs.

Why couldn't PDAs be served by the 'old' driver then?  Old doesn't mean obsolete.

Also embedded world != PDAs.  I was thinking more of things like PVRs, and blade
servers.  What about solid state video cameras?  Are they going to use PIO mode
ATA?

John.
