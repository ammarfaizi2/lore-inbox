Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTEPSQD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTEPSQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:16:03 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:45212 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264531AbTEPSQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:16:02 -0400
Date: Fri, 16 May 2003 19:30:33 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andreas Henriksson <andreas@fjortis.info>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm6
Message-ID: <20030516183033.GA18042@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andreas Henriksson <andreas@fjortis.info>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030516015407.2768b570.akpm@digeo.com> <20030516172834.GA9774@foo> <20030516175539.GA16626@suse.de> <20030516181042.GA556@foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516181042.GA556@foo>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 08:10:42PM +0200, Andreas Henriksson wrote:

 > Ok.. thanks for the quick reply .. I just booted the kernel and noticed
 > that the console got stuck (but the it booted fine except from that).

The reports I've seen have shown that i810fb outputs some warnings
during startup about being unable to allocate using agpgart.
As i810fb depends on agp, this would imply its functionality would break.
Are you sure it's working, and not falling back to non-fb mode ?

 > And by the way.... the framebuffer flickers (is that the right word?)
 > for me.... It looks like an old TV... (Has done with all the (2.5)
 > kernels I've tried).. Is this a known problem and if so is there a
 > solution?
 > I'm using a TFT monitor and this is my append-line..
 > append="video=i810fb:xres:1280,yres:1024,bpp:16,hsync1:30,hsync2:82, \
 > 		vsync1:50,vsync2:75,accel"
 > (... if it matters.)

That's probably one for Antonio to figure out, unfortunatly he's busy
right now.

		Dave

