Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTFKOoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTFKOoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:44:23 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:59267 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261773AbTFKOoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:44:22 -0400
Date: Wed, 11 Jun 2003 09:59:10 -0400
From: Ben Collins <bcollins@debian.org>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK-CVS gateway] version tags
Message-ID: <20030611135910.GO4695@phunnypharm.org>
References: <Pine.LNX.4.44.0306111641140.1602-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306111641140.1602-100000@neptune.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 04:44:37PM +0200, Pascal Schmidt wrote:
> 
> Hi!
> 
> I noticed both the 2.4 and 2.5 BK->CVS trees don't have version tags
> any more (v2_5_70, for example, as in the old tree).
> 
> Is this intentional? Did CVS take too long to tag all files or something?
> 
> It was quite a nice feature to have them, very useful for finding out the
> differences between certain kernel versions. I can live without it, 
> though. It's still a nice service without the tags. (Thanks!)

Looks like the tags are on the ChangeSet file only. Which is why I
didn't notice. You could get a timestamp from the tag on ChangeSet and
use that for a -D argument.

A quick script could do this for you. I think it's wise of Larry to keep
it this way.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
