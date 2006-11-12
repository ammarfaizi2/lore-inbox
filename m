Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755091AbWKLMbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbWKLMbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 07:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755090AbWKLMbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 07:31:12 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:20165 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755089AbWKLMbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 07:31:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Sun, 12 Nov 2006 13:28:35 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com> <1163285379.4982.233.camel@localhost.localdomain> <20061112121334.GC9989@elf.ucw.cz>
In-Reply-To: <20061112121334.GC9989@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121328.36267.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 12 November 2006 13:13, Pavel Machek wrote:
> Hi!
> 
> > > Then the radeonfb doesn't kick in at all (guess some pci ids are added
> > > in that patch).
> > > 
> > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > 
> > In that case (vesafb), when does the screen come back precisely ? Do you
> > get console mode back and then X ? Or it only comes back when going back
> > to X ? Do you have some userland-type vbetool thingy that bring it
> > back ?
> 
> He's using s3_bios+s3_mode, so kernel does some BIOS calls to reinit
> the video. It should come out in text mode, too.
> 
> Christian, can you unload radeonfb before suspend/reload it after
> resume?
> 
> Next possibility is setting up serial console and adding some printks
> to radeon...

I guess this box has no serial ports, but netconsole should do (provided
there's another box nearby on which netcat can be run).

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
