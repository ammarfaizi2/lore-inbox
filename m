Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbTHYIdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 04:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbTHYIdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 04:33:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9345 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261657AbTHYIdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 04:33:43 -0400
Date: Mon, 25 Aug 2003 09:45:30 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308250845.h7P8jUj8000566@81-2-122-30.bradfords.org.uk>
To: jamie@shareable.org, vojtech@ucw.cz
Subject: Re: Input issues - key down with no key up
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       vojtech@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >   Serge van den Boom reports that his LiteOn MediaTouch Keyboard
> > > >   has 18 additional keys: Suspend, Coffee, WWW, Calculator, Xfer,
                                           ^^^^^^
What does that do?

> I'll give you a kernel/module option to disable the forced up effect if
> you have a perfect keyboard. You can then also enable the untranslated
> mode and set 3. But the default will be translated set 2 with forced
> keyups if a key is not repeating.

Exactly - code to accomodate any PS/2 keyboard that doesn't do
untranslated set 3 is a workaround, in my opinion.  People with
perfect keyboards should be able to benefit from the simplicity they
allow.  Obviously 'set 2 + workarounds' needs to be the default,
because of the hardware in existance, but there is still an advantage
to using set 3 where possible.

John.
