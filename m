Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTHVA1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTHVA1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:27:13 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:9480 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262945AbTHVA1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:27:11 -0400
Date: Fri, 22 Aug 2003 02:27:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Jamie Lokier <jamie@shareable.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030822022709.A3640@pclin040.win.tue.nl>
References: <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL> <20030815135248.GA7315@win.tue.nl> <20030815141328.GA16176@ucw.cz> <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl> <20030821080145.GA11263@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030821080145.GA11263@ucw.cz>; from vojtech@suse.cz on Thu, Aug 21, 2003 at 10:01:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 10:01:45AM +0200, Vojtech Pavlik wrote:

> > > UNLESS there are keys which do report UP when the key
> > > is released (as opposed to immediately after the DOWN),
> > > and also don't repeat.
> > 
> > And there are keyboards with such keys.
> 
> Are there?

I owe you an example. See, for example,
	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html#ss5.29

Abbreviated version:
  Serge van den Boom reports that his LiteOn MediaTouch Keyboard has 18
  additional keys: Suspend, Coffee, WWW, Calculator, Xfer, Switch window,
  Close, |<<, >|, [], >>|, Record, Rewind, Menu, Eject, Mute, Volume +,
  and Volume -. Of these, the keys |<<, >>|, Volume +, Volume - repeat.
  The others do not, except for the rather special Switch window key.
  Upon press it produces the LAlt-down, LShift-down, Tab-down, Tab-up sequence;
  it repeats Tab-down; and upon release it produces the sequence Tab-up,
  LAlt-up, LShift-up.
(Up events are as usual for the other 17 keys.)

