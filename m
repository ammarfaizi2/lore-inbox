Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbTIZPZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTIZPZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:25:01 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:3483 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262354AbTIZPY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:24:59 -0400
Date: Fri, 26 Sep 2003 17:24:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030926152451.GA10799@ucw.cz>
References: <1064572898.21735.17.camel@ulysse.olympe.o2t> <1064581715.23200.9.camel@ulysse.olympe.o2t> <20030926134116.GA9721@ucw.cz> <1064585567.23200.15.camel@ulysse.olympe.o2t> <20030926141750.GA10183@ucw.cz> <1064586116.23200.17.camel@ulysse.olympe.o2t> <20030926142607.GA10344@ucw.cz> <1064587824.23200.19.camel@ulysse.olympe.o2t> <20030926150628.GA10521@ucw.cz> <1064589686.23200.24.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1064589686.23200.24.camel@ulysse.olympe.o2t>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 05:21:26PM +0200, Nicolas Mailhot wrote:
> Le ven 26/09/2003 ? 17:06, Vojtech Pavlik a écrit :
> > On Fri, Sep 26, 2003 at 04:50:25PM +0200, Nicolas Mailhot wrote:
> > > Le ven 26/09/2003 ? 16:26, Vojtech Pavlik a écrit :
> > > > On Fri, Sep 26, 2003 at 04:21:57PM +0200, Nicolas Mailhot wrote:
> > > > > Le ven 26/09/2003 ? 16:17, Vojtech Pavlik a écrit :
> 
> > > > > > If that doesn't work, you have a more severe problem than a stuck key,
> > > > > > that wouldn't be solved by stopping the repeat.
> > > > > 
> > > > > It stops the repeat all right.
> > > > > The problem is the keyboard is dead afterwards:(
> > > > 
> > > > That's very interesting. Can you enable DEBUG in i8042.c and post a log?
> > > 
> > > Will it be of any use for an USB keyboard ? (just asking)
> > 
> > No. For an USB keyboard I'd suggest unplugging it, then re-plugging and
> > then it should work. Then look at what 'dmesg' says.
> 
> Ok. I think I've already tried this and the outcome was not satisfying,
> and I sort of remember dmesg was empty. I'll try this with usb debug
> enabled this evening or next monday. (I just hope something comes out of
> this - 2.6 is great till the keyboard goes mad).

You can also enable DEBUG in hid-core.c.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
