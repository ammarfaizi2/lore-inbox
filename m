Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTKQQhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTKQQhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:37:39 -0500
Received: from jupiter.loonybin.net ([208.248.0.98]:54545 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S263573AbTKQQhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:37:34 -0500
Date: Mon, 17 Nov 2003 10:37:29 -0600
From: Zinx Verituse <zinx@epicsol.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serio chaining in 2.6.x?
Message-ID: <20031117163729.GA5430@bliss>
References: <20031117030652.GA4108@bliss> <20031117074748.GA27370@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117074748.GA27370@ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 08:47:48AM +0100, Vojtech Pavlik wrote:
> On Sun, Nov 16, 2003 at 09:06:52PM -0600, Zinx Verituse wrote:
> >
[snip]
> > What do you folks think the best method for chaining the
> > serio drivers is?
> 
> You grab the port. Then you create a new one and register it. And you
> forward all data that's not destined for you through to the new serio
> port.
> 
> -- 
> Vojtech Pavlik

Many thanks -- I hadn't considered creating a new port, and I'm sure this
solution will work perfectly :)

-- 
Zinx Verituse
