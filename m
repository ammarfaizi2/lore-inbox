Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbUBXPxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbUBXPxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:53:23 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:1207 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262299AbUBXPxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:53:12 -0500
Date: Tue, 24 Feb 2004 10:33:07 -0500
From: Ben Collins <bcollins@debian.org>
To: Tillmann Steinbrecher <t-st@t-st.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.3 + external firewire dvd writer - frequent freezes
Message-ID: <20040224153307.GG468@phunnypharm.org>
References: <403B7245.1000208@t-st.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403B7245.1000208@t-st.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for your reply.  What option do I have to enable exactly? 
> CONFIG_DEBUG_SPINLOCK_SLEEP? Anything else required? Also, how do I get 
> access to the results of the debugging? I mean, it's really a hard 
> crash, no messages visible (that is, when running X), no logging to 
> syslog, etc.

That should be good. You'll have to do this from the console (not in X)
and if it's a spinlock deadlock, it will print messages.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
