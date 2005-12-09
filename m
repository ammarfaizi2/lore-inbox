Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVLIPeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVLIPeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVLIPeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:34:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:37075 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932243AbVLIPef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:34:35 -0500
Date: Fri, 9 Dec 2005 16:34:33 +0100
From: Olaf Hering <olh@suse.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209153433.GB26963@suse.de>
References: <20051209140559.GA23868@suse.de> <20051209152530.GE15372@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051209152530.GE15372@harddisk-recovery.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Dec 09, Erik Mouw wrote:

> > 'ctrl o' is currently mapped to 'flush output', see 'stty -a'
> 
> Eww... If you can't use a serial break, why can't you use an
> established control character like ctrl-] (telnet) or [enter]~ (ssh) ?

There are many ways to get to the console session on the HMC. One is
ssh. But maybe this would work somehow.

> If you really want to use ctrl-o, could you make a way that pressing
> ctrl-o twice sends a single ctrl-o to the process attached to the
> console?

Sounds good. Have to check how to handle that. 

> If it is a POWER4-only problem, why isn't there a dependency on
> CONFIG_POWER4 over here? I don't like to have the ctrl-o sysrq stuff
> enabled on my regular PC if it only matters to some rare (in absolute
> numbers) system.

More CONFIG_PPC_PSERIES, the mentioned option is for gcc optimization.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
