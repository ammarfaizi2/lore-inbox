Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbTF1HsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 03:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbTF1HsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 03:48:25 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9088 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265101AbTF1HsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 03:48:23 -0400
Date: Sat, 28 Jun 2003 09:10:32 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306280810.h5S8AWqi000513@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, lm@bitmover.com, mbligh@aracnet.com
Subject: Re: networking bugs and bugme.osdl.org
Cc: davem@redhat.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This might help.  Or not.
> >
> > Brain dump on the bug tracking problem from the Kernel Summit discussions
>
> I implemented the vast majority of this months ago, in my bug database:
>
> http://www.grabjohn.com/kernelbugdatabase/
>

[snip]

> > Problem details
> >     Bug report quality
> >     	There was lots of discussion on this.  The main agreement was that we
> > 	wanted the bug reporting system to dig out as much info as possible
> > 	and prefill that.  There was a lot of discussion about possible tools
> > 	that would dig out the /proc/pci info; there was discussion about
> > 	Andre's tools which can tell you if you can write your disk; someone
> > 	else had something similar.
>
> This is controversial, due to the potential for unwanted information
> disclosure.  I purposely didn't implement it.  If a large proportion
> of users want it implemented, just let me know.

Having said that, I've had a .config uploading and analysing facility
since version 1.0.  Infact, the reason I forgot to mention it in my
first E-Mail, is that it is the core around which the whole Kernel Bug
Database operates.  The user uploads their .config, and the database
finds bugs that might be the one you're experiencing.  If so, you add
a separate bug report, an admin collects both bug reports in to one
confirmed bug, and picks out which config options he wants to flag as
causing the confirmed bug.

John.
