Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbTHUOoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTHUOoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:44:39 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:42761 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262727AbTHUOoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:44:37 -0400
Date: Thu, 21 Aug 2003 16:44:35 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Andries Brouwer <aebr@win.tue.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821164435.B3518@pclin040.win.tue.nl>
References: <20030821141457.GA24409@ucw.cz> <Pine.GSO.3.96.1030821163104.2489K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030821163104.2489K-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 21, 2003 at 04:33:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 04:33:04PM +0200, Maciej W. Rozycki wrote:

>  Hmm, that would make some sense, but how does it work when an external
> keyboard is attached?

Usually the keyboard and mouse commands are sent to all attached
keyboards resp. mice. Thus, with an internal keyboard that only
knows about Set 2 and an external keyboard that also knows about
Set 3 you can change the kbds to Set 3. Now the internal one is
dead, but the external one functions.

