Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271838AbTGXXkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271839AbTGXXkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:40:17 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:923 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S271838AbTGXXkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:40:14 -0400
Date: Thu, 24 Jul 2003 19:45:03 -0400
From: Ben Collins <bcollins@debian.org>
To: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Firewire
Message-ID: <20030724234503.GR1512@phunnypharm.org>
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org> <20030724230928.GB23196@ruvolo.net> <20030724231421.GQ1512@phunnypharm.org> <20030724234837.GC23196@ruvolo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724234837.GC23196@ruvolo.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 04:48:37PM -0700, Chris Ruvolo wrote:
> On Thu, Jul 24, 2003 at 07:14:21PM -0400, Ben Collins wrote:
> > I've seen this before, but I can never reproduce it. Not with i386, nor
> > with sparc64, and not running 2.4 or 2.6. I know what is happening
> > though. The response packet is getting processed before the status
> > packet (IOW, the ack for your request is getting back after the actual
> > response to your request).
> > 
> > Not sure how that is possible, but I suspect it's just a bit of logic
> > that needs to be applied, or queue the replies waiting for the ack.
> 
> That is very odd, considering it works under 2.4.  Is it possible the
> pending_packets list isn't being updated?  Would the verbose debug option
> help?

If it wasn't being updated, I would see the problem too, and I'm not.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
