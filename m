Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTKQRuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTKQRuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:50:24 -0500
Received: from jupiter.loonybin.net ([208.248.0.98]:34578 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S263598AbTKQRuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:50:20 -0500
Date: Mon, 17 Nov 2003 11:50:10 -0600
From: Zinx Verituse <zinx@epicsol.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serio chaining in 2.6.x?
Message-ID: <20031117175010.GA6101@bliss>
References: <20031117030652.GA4108@bliss> <20031117074748.GA27370@ucw.cz> <20031117163729.GA5430@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117163729.GA5430@bliss>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 10:37:29AM -0600, Zinx Verituse wrote:
> On Mon, Nov 17, 2003 at 08:47:48AM +0100, Vojtech Pavlik wrote:
> > On Sun, Nov 16, 2003 at 09:06:52PM -0600, Zinx Verituse wrote:
> > >
> [snip]
> > > What do you folks think the best method for chaining the
> > > serio drivers is?
> > 
> > You grab the port. Then you create a new one and register it. And you
> > forward all data that's not destined for you through to the new serio
> > port.
> > 
> > -- 
> > Vojtech Pavlik
> 
> Many thanks -- I hadn't considered creating a new port, and I'm sure this
> solution will work perfectly :)
> 

Unfortunately, I hit a snag...  I can't see a way to rescan or
disconnect all the ports that need intercepted (or, indeed, any of
them that are already connected)

Suggestions welcome :)

-- 
Zinx Verituse
