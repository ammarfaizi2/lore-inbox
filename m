Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269537AbTGJSgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269539AbTGJSgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:36:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40972 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269537AbTGJSgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:36:33 -0400
Date: Thu, 10 Jul 2003 20:51:12 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>, jack@suse.cz,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_QFMT_V2 vs. `VFS v0 quota format support'
Message-ID: <20030710185112.GB8678@atrey.karlin.mff.cuni.cz>
References: <Pine.GSO.4.21.0307101748020.3972-100000@vervain.sonytel.be> <20030710165346.A28322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710165346.A28322@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jul 10, 2003 at 05:50:33PM +0200, Geert Uytterhoeven wrote:
> > 
> > Why does the help text for CONFIG_QFMT_V2 say `VFS v0 quota format support' and
> > not `VFS v2 quota format support'?
> 
> Ask Jan, that's the name he's been using all through the development of
> the patch and in the quota tools.
  At the beginning I started calling the original quota format 'old' and
the new one 'v0' (because in the quota file there's written 0 in the
version  field ;)). If I did the decision now I would name it
differently...
  In the code on the other hand I started naming the formats v1 and v2
because internal type identifiers are '1' and '2'.
  So I agree that this is a bit messy but I'm not sure it's worth
renaming.

								Honza
  
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
