Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUBGXLU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 18:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUBGXLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 18:11:20 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:24199 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261270AbUBGXLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 18:11:19 -0500
Date: Sat, 7 Feb 2004 18:08:17 -0500
From: Ben Collins <bcollins@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-ID: <20040207230817.GU1042@phunnypharm.org>
References: <fa.h1qu7q8.n6mopi@ifi.uio.no> <402240F9.3050607@gadsdon.giointernet.co.uk> <20040205182614.GG13075@kroah.com> <20040206144729.GJ1042@phunnypharm.org> <20040206182200.GE32116@kroah.com> <20040207172757.GQ1042@phunnypharm.org> <20040207191315.GC2581@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207191315.GC2581@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > One thing I notice is that I am not checking the return value of
> > device_register(), however if that fails, the device shouldn't be in the
> > device list for the bus, correct?
> 
> That is correct.  I don't see the problem either in looking at your
> code...

Well, unless someone finds eveidence to the contrary, I'm going to
assume this isn't a bug in ieee1394 :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
