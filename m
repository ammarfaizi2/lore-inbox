Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTHUOdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbTHUOdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:33:15 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:46542 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262683AbTHUOdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:33:14 -0400
Date: Thu, 21 Aug 2003 16:33:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jamie Lokier <jamie@shareable.org>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030821141457.GA24409@ucw.cz>
Message-ID: <Pine.GSO.3.96.1030821163104.2489K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Vojtech Pavlik wrote:

> Yes, but on a notebook, you often don't have a microcontroler in the
> keyboard itself, and there is no wire over which the untranslated set2
> scancodes would be passed. The i8042 directly scans the keyboard matrix.
> Then it's easy to forget about the set3 scancode set ...

 Hmm, that would make some sense, but how does it work when an external
keyboard is attached?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

