Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbTIZPGd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbTIZPGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:06:33 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7066 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262338AbTIZPGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:06:31 -0400
Date: Fri, 26 Sep 2003 17:06:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030926150628.GA10521@ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t> <20030926102403.GA8864@ucw.cz> <1064572898.21735.17.camel@ulysse.olympe.o2t> <1064581715.23200.9.camel@ulysse.olympe.o2t> <20030926134116.GA9721@ucw.cz> <1064585567.23200.15.camel@ulysse.olympe.o2t> <20030926141750.GA10183@ucw.cz> <1064586116.23200.17.camel@ulysse.olympe.o2t> <20030926142607.GA10344@ucw.cz> <1064587824.23200.19.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1064587824.23200.19.camel@ulysse.olympe.o2t>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 04:50:25PM +0200, Nicolas Mailhot wrote:
> Le ven 26/09/2003 ? 16:26, Vojtech Pavlik a écrit :
> > On Fri, Sep 26, 2003 at 04:21:57PM +0200, Nicolas Mailhot wrote:
> > > Le ven 26/09/2003 ? 16:17, Vojtech Pavlik a écrit :
> > > > On Fri, Sep 26, 2003 at 04:12:47PM +0200, Nicolas Mailhot wrote:
> > > >  
> > > > > The difference being the system can then try to rescue my keyboard;)
> > > > > Right now the only fix I have is to reboot the system because there is
> > > > > precious little I can do with a stuck keyboard. Thank god software
> > > > > reboot is always possible be it with the mouse or the acpi button.
> > > > > 
> > > > > (and this also solves the case when something falls on a keyboard which
> > > > > does happen now and then. I don't mind a screen of j's when the
> > > > > alternative is 200 j's screenfulls)
> > > > 
> > > > You can simply press any key and it'll stop repeating. 
> > > > 
> > > > If that doesn't work, you have a more severe problem than a stuck key,
> > > > that wouldn't be solved by stopping the repeat.
> > > 
> > > It stops the repeat all right.
> > > The problem is the keyboard is dead afterwards:(
> > 
> > That's very interesting. Can you enable DEBUG in i8042.c and post a log?
> 
> Will it be of any use for an USB keyboard ? (just asking)

No. For an USB keyboard I'd suggest unplugging it, then re-plugging and
then it should work. Then look at what 'dmesg' says.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
