Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271071AbTHQVzH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271073AbTHQVzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:55:07 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:12217 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S271071AbTHQVzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:55:04 -0400
Date: Sun, 17 Aug 2003 23:54:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030817215436.GA24933@ucw.cz>
References: <20030815135331.GC15872@ucw.cz> <Pine.GSO.3.96.1030816150153.15339E-100000@delta.ds2.pg.gda.pl> <20030816140901.GC23646@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030816140901.GC23646@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 03:09:01PM +0100, Jamie Lokier wrote:
> Maciej W. Rozycki wrote:
> > On Fri, 15 Aug 2003, Vojtech Pavlik wrote:
> > > > The PS/2 keyboard protocol is utterly absurd.
> > > Yep. It's a dozen or more years of hack upon a hack.
> >  Well, mode #3 with no translation in the i8042 looks quite sanely. 
> 
> What are the known problems with mode #3, then?

It's broken on many keyboards (on some only slightly, like some keys not
working properly). Other (special, either unix workstation or point of
sale) keyboards need it to work properly.

> That is, why doesn't everyone use it and why haven't they always used it?

Because old AT keyboards didn't support it. Because the XT keyboard
didn't support it. Because history sticks.

> For that matter, what does Windows use?

Translated Set 2. Actually an emulated XT keyboard.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
