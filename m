Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUCIPzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUCIPzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:55:06 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:42469 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261932AbUCIPzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:55:01 -0500
Date: Tue, 9 Mar 2004 10:41:04 -0500
From: Ben Collins <bcollins@debian.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS when copying data from local to an external drive (ieee1394)
Message-ID: <20040309154104.GA16853@phunnypharm.org>
References: <200403070139.30268.dtor_core@ameritech.net> <Pine.LNX.4.58.0403070229490.29087@montezuma.fsmlabs.com> <200403090211.33930.dtor_core@ameritech.net> <Pine.LNX.4.58.0403091015280.29087@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403091015280.29087@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 10:16:40AM -0500, Zwane Mwaikambo wrote:
> On Tue, 9 Mar 2004, Dmitry Torokhov wrote:
> 
> > > Does this patch help any?
> > >
> >
> > Unfortunately I am still getting oopses with exactly the same call trace.
> > On top of that I am now seeing the following in the logs:
> 
> Thanks for testing it, the messages below look like they may be due to
> something else.

No, that's exactly from your patch. The locking your patch added seems
to be wrong. I'm looking into the issue already.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
