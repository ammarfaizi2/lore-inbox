Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUCCUG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 15:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUCCUG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 15:06:56 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:2983 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261156AbUCCUGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 15:06:54 -0500
Date: Wed, 3 Mar 2004 14:59:37 -0500
From: Ben Collins <bcollins@debian.org>
To: kai.engert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Update on ieee1394 trouble with latest 2.4.x
Message-ID: <20040303195937.GG1078@phunnypharm.org>
References: <404635E6.50409@kuix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404635E6.50409@kuix.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 08:45:42PM +0100, Kai Engert wrote:
> A couple of days ago I posted a report about my problems with ieee1394 
> mass storage devices to the list. Here is an update.
> 
> Meanwhile Ben Collins contacted me and recommend me to try out some sbp2 
> module options.
> 
> It turned out the "stall and timeout" problem can be suppressed by using 
> the sbp2_serialize_io=1 module param when loading module sbp2. This 
> works for me with several devices I have tested.

I think I may end up making this the default for this option in 2.4.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
