Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbTHUNow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTHUNn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:43:56 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:39882 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262683AbTHUN3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 09:29:14 -0400
Date: Thu, 21 Aug 2003 15:29:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Jamie Lokier <jamie@shareable.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030821144835.B3480@pclin040.win.tue.nl>
Message-ID: <Pine.GSO.3.96.1030821152015.2489F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Andries Brouwer wrote:

> >  X11 is another example of software that wants to know the state of keys
> > continuously.  And that's not a piece of software to ignore easily. 
> 
> You are both inventing the situation that games, or X11, ask the kernel
> for a bitmap of pressed keys. But they don't. The mechanism doesn't
> even exist.

 I don't know of any games, but X11 doesn't work that way.  What I mean
X11 needs to know what keys are currently pressed and which are not.  It
handles that itself by tracking key presses and releases for all keys, so
both kinds of events need to be reported properly.  OTOH, the console
doesn't really care about key releases except from modifier keys. 

 I'm sorry if my statement was ambiguous. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

