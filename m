Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270811AbTHPNBy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 09:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270867AbTHPNBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 09:01:54 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:62593 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S270811AbTHPNBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 09:01:53 -0400
Date: Sat, 16 Aug 2003 15:01:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jamie Lokier <jamie@shareable.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: <20030815133307.GH15911@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.3.96.1030816145830.15339D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003, Jamie Lokier wrote:

> Aren't there some keys which report DOWN and UP but which don't repeat?
> 
> The PS/2 keyboard protocol is utterly absurd.

 In mode #3 you can configure press/release/repeat characteristics of
every key separately, although the sane default might be to set all keys
to report all three kinds of events.  The exception might of course be
buggy hardware. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

