Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276049AbTHONFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276052AbTHONFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:05:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:32897 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S276049AbTHONFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:05:01 -0400
Date: Fri, 15 Aug 2003 14:04:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815130450.GF15911@mail.jlokier.co.uk>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <20030815123641.GA7204@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815123641.GA7204@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> Yes, it would still be considered down. But that does not imply
> that pressing it doesnt do anything. It is up to the driver
> to discard key presses, and I think it shouldnt.
> (Unless of course the user asks for that behaviour - it may be required
> on some broken laptops.)

It should discard multiple presses of the same key in very rapid
succession, when that is immediately after the first press of that
key.  (After a time has passed, rapid successive presses are due to
auto-repeat, which is ok).

Several laptops seem to send a key down event 3, 5 or very many times
in response to a single press.

-- Jamie
