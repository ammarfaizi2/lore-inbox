Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUCPNUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUCPNUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:20:36 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:63169 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261491AbUCPNUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:20:30 -0500
Date: Tue, 16 Mar 2004 07:59:23 -0500
From: Ben Collins <bcollins@debian.org>
To: Tillmann Steinbrecher <t-st@t-st.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Firewire-related crashes in 2.6.4
Message-ID: <20040316125923.GL7711@phunnypharm.org>
References: <1079438920.2947.10.camel@paranoia.pallasnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079438920.2947.10.camel@paranoia.pallasnet.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 01:08:40PM +0100, Tillmann Steinbrecher wrote:
> Hi,
> 
> although not as unstable as in 2.6.3, the usage of my external FireWire
> drive (Plextor 708A DVD burner with Oxford 911 FireWire interface) is
> still causing freezes. This time the freezes occur randomly when reading
> files from the drive, or when trying to rip a video DVD. It's a hard
> crash - no mouse movement, no ping on the network. It is not always
> reproducible, but occurs frequently.
> 
> Here's a screenshot of the resulting kernel panic (sorry for the .jpg, I
> couldn't paste it as text, for obvious reasons):
> 
> http://www.t-st.org/panic.jpg

This is fixed in our latest SVN repo. There were some race issues around
the packet lists.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
