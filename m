Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbTHUNnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbTHUNnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:43:15 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:31499 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262667AbTHUMsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:48:37 -0400
Date: Thu, 21 Aug 2003 14:48:35 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jamie Lokier <jamie@shareable.org>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821144835.B3480@pclin040.win.tue.nl>
References: <20030821000302.GC24970@mail.jlokier.co.uk> <Pine.GSO.3.96.1030821133902.2489C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030821133902.2489C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 21, 2003 at 01:40:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 01:40:33PM +0200, Maciej W. Rozycki wrote:
> On Thu, 21 Aug 2003, Jamie Lokier wrote:
> 
> > But for programs which want to monitor a key and know its state
> > continuously (this presently includes the software autorepeater, but
> > it also includes games), none of the behaviours is right.
> 
>  X11 is another example of software that wants to know the state of keys
> continuously.  And that's not a piece of software to ignore easily. 

You are both inventing the situation that games, or X11, ask the kernel
for a bitmap of pressed keys. But they don't. The mechanism doesn't
even exist.


