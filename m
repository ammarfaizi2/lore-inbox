Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUBWTX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUBWTX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:23:58 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:49838 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261998AbUBWTX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:23:57 -0500
Date: Mon, 23 Feb 2004 14:04:32 -0500
From: Ben Collins <bcollins@debian.org>
To: Tillmann Steinbrecher <t-st@t-st.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.3 + external firewire dvd writer - frequent freezes
Message-ID: <20040223190432.GD388@phunnypharm.org>
References: <4038B244.2020209@t-st.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4038B244.2020209@t-st.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 02:44:36PM +0100, Tillmann Steinbrecher wrote:
> Hi,
> 
> I'm using an external FireWire DVD writer (Plextor 708 in case w/Oxford
> 911 chipset). This was working fine until kernel 2.6.2.
> 
> Since I upgraded to 2.6.3, it frequently happens that the system totally
> freezes when trying to write a DVD. It's really a hard crash, no mouse
> movement, no ping on the network. Reset required.
> 
> It doesn't happen each time I try to burn a DVD, but in about 20% the
> cases. So basically the writer is unusable with 2.6.3.
> 
> I searched the web and archives for the problem, but didn't find any
> results, except for one guy describing the same problem, also with
> 2.6.3, also on this mailing list here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0402.2/0950.html
> 
> However he didn't get any replies.
> 
> Please CC: me for replies, or if anybody needs .config, lspci, or other
> info. The firewire controller is a Texas Instruments TSB43AB22/A.

Can you enable spinlock debug so we can see if this is a race condition
somewhere?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
