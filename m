Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270829AbTGPN4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270839AbTGPN4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:56:05 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:5830 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S270829AbTGPN4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:56:02 -0400
Date: Wed, 16 Jul 2003 10:10:08 -0400
From: Ben Collins <bcollins@debian.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] fix warning in iee1394 nodemgr
Message-ID: <20030716141008.GE685@phunnypharm.org>
References: <Pine.LNX.4.53.0307160159330.32541@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307160159330.32541@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:01:12AM -0400, Zwane Mwaikambo wrote:
> Looks like a sensible default
> 
> drivers/ieee1394/nodemgr.c: In function `nodemgr_host_thread':
> drivers/ieee1394/nodemgr.c:1621: warning: `generation' might be used uninitialized in this function

Not a good default, but I'll fix it.

I'm a little concerned that I've never seen either of the two warnings
you showed. I've been building with -Werror for awhile now.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
