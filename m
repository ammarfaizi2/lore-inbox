Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUADCto (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 21:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUADCtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 21:49:43 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:27658 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264479AbUADCtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 21:49:42 -0500
Date: Sun, 4 Jan 2004 03:49:34 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040104034934.A3669@pclin040.win.tue.nl>
References: <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl> <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org> <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401031802420.2162@home.osdl.org>; from torvalds@osdl.org on Sat, Jan 03, 2004 at 06:09:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 06:09:47PM -0800, Linus Torvalds wrote:
> On Sun, 4 Jan 2004, Andries Brouwer wrote:

> > Empty talk. This is not about finding and fixing bugs.
> > We know very precisely what properties the NFS protocol has.
> > Now one can have a system that works as well as possible with NFS.
> > And one can have a worse system.
> 
> Oh, things can be _much_ worse than /dev over NFS.

Yes, but why do you start saying that?

Our topic is the statement that it is good to have device numbers
stable across a reboot. Not absolutely necessary, but good.

For example, given an NFS mount, if the server reboots and
suddenly the client sees different stat data, that would be
less than optimal. A low quality NFS implementation.

You write long stories - but it really is desirable to have
stable device numbers.

> You don't seem to realize what I mean with "not enumerable".

One of your side avenues is the matter of enumeration.
I don't see why that would be relevant. One identifies
things by their UUID. Order is never important.

> And there just _isn't_ any way to make them the same or to "describe" the 
> storage in any integer of any finite length. It has nothing to do with 
> 32-bit vs 64-bit vs 1024-bit.

A UUID usually takes 128 bits.

Andries

