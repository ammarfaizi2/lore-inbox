Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVIKWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVIKWfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVIKWfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:35:23 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:61391 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750990AbVIKWfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:35:23 -0400
Date: Mon, 12 Sep 2005 00:36:19 +0200
To: Martin Mares <mj@ucw.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Zoltan Szecsei <zoltans@geograph.co.za>,
       linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
Message-ID: <20050911223619.GB19403@aitel.hist.no>
References: <4316E5D9.8050107@geograph.co.za> <20050901122253.GA11787@midnight.suse.cz> <4316FD08.1070505@geograph.co.za> <20050901132409.GA29134@midnight.suse.cz> <20050901144812.GA3483@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901144812.GA3483@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:48:12PM +0200, Martin Mares wrote:
> Hello!
> 
> > Btw, Aivils Stoss created a nice way to make several X instances have
> > separate keyboards - see the linux-console archives for the faketty
> > driver.
> 
> I haven't looked recently, but when I tried that several years ago,
> the biggest problem was to make two simultaneously running X servers
> not switch off each other's video card I/O ports off :)
> 
Look again.  X config files now have "IsolateDevice" and "BusID"
to deal with this.  At least iff you get your X from ubuntu or
debian testing . . .

> All other things looked solvable with a reasonably small effort.

It works quite well. :-)

Helge Hafting
