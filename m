Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTDQCge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 22:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTDQCgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 22:36:33 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.92.226.148]:56807 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262515AbTDQCgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 22:36:33 -0400
Date: Wed, 16 Apr 2003 22:48:00 -0400
From: Dan Maas <dmaas@maasdigital.com>
To: Philippe Gramoull? <philippe.gramoulle@mmania.com>
Cc: Steve Kinneberg <kinnebergsteve@acmsystems.com>,
       Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Linux1394dev <linux1394-devel@lists.sourceforge.net>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then hard freeze ( lockup on CPU0)
Message-ID: <20030416224800.A706@morpheus>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com> <20030415160530.2520c61c.akpm@digeo.com> <20030416004933.GI16706@phunnypharm.org> <20030416184528.19c20372.philippe.gramoulle@mmania.com> <1050514375.589.1843.camel@stevek> <20030417003031.2b603167.philippe.gramoulle@mmania.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030417003031.2b603167.philippe.gramoulle@mmania.com>; from philippe.gramoulle@mmania.com on Thu, Apr 17, 2003 at 12:30:31AM +0200
X-Info: http://www.maasdigital.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since then, i only got these "reset storms" versions over versions.

Jim Radford's nodemgr back-off patch fixes the reset storms, for me at
least. (check the list archives, he posted it a few weeks ago).

It should definitely be applied, but I would hold off until we fix the
nodemgr crash bug, since Jim's patch masks (but does not eliminate) it.
I'd rather force people to deal with the nodemgr crash :)

(if nobody picks up the torch on nodemgr, I'll try myself in a few
days - I'm too busy now but boy I want it FIXED! :)

Regards,
Dan
