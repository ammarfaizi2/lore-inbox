Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264663AbUEaPHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbUEaPHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 11:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUEaPHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 11:07:52 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:6866 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264663AbUEaPHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 11:07:51 -0400
Date: Mon, 31 May 2004 10:29:33 -0400
From: Ben Collins <bcollins@debian.org>
To: Dan Kegel <dank@kegel.com>
Cc: bjornw@axis.com, linux-kernel@vger.kernel.org
Subject: Re: Delete cris architecture?
Message-ID: <20040531142933.GA11678@phunnypharm.org>
References: <40BB3751.6060200@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BB3751.6060200@kegel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 06:46:57AM -0700, Dan Kegel wrote:
> on linux-2.6.6, 'make oldconfig' fails on cris with
> 
> scripts/kconfig/conf -o arch/cris/Kconfig
> arch/cris/Kconfig:158: can't open file "arch/cris/drivers/Kconfig"
> make[1]: *** [oldconfig] Error 1
> 
> This was reported about a year ago on 2.6.0-test2:	
> http://mhonarc.axis.se/dev-etrax/msg03456.html
> but it seems nothing has been done about it.
> 
> Since step 1 of building a linux kernel for cris seems to have
> been dead in the water for almost a year with no
> action from the port's maintainer, perhaps the port
> should be deleted from the main kernel tree.

If you delete it, there's less chance of someone picking it up as the
new maintainer. It will kill an obvious starting point for someone
wanting to continue the work on it.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
