Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270997AbTGVTBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270998AbTGVTBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:01:52 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:45328 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270997AbTGVTBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:01:51 -0400
Date: Tue, 22 Jul 2003 21:16:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       James Simmons <jsimmons@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Samuel Flory <sflory@rackable.com>, Charles Lepple <clepple@ghz.cc>,
       michaelm <admin@www0.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: Make menuconfig broken
Message-ID: <20030722191646.GB2003@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Simmons <jsimmons@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Samuel Flory <sflory@rackable.com>, Charles Lepple <clepple@ghz.cc>,
	michaelm <admin@www0.org>, linux-kernel@vger.kernel.org,
	vojtech@suse.cz
References: <Pine.LNX.4.44.0307221146120.714-100000@serv> <Pine.LNX.4.44.0307221735160.5483-100000@phoenix.infradead.org> <20030722191746.A13975@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722191746.A13975@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 07:17:46PM +0100, Christoph Hellwig wrote:
> 
> If you really want that do it a a separate make updateconfig script instead
> of bloating make oldconfig.

updateconfig is definetely more acceptable than bloating oldconfig.
But would we end up with lots of hacks - and where do we stop.
Do we want to go the whole way back to a 2.0 .config and do an
acceptable .config using:
make updateconfig

Or is this limited to 2.4 -> 2.6?

	Sam
