Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTIPWtc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 18:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbTIPWtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 18:49:32 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:38016
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262543AbTIPWta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 18:49:30 -0400
Date: Tue, 16 Sep 2003 18:49:22 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another keyboard woes with 2.6.0...
In-Reply-To: <20030916232318.A1699@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.53.0309161844380.23370@montezuma.fsmlabs.com>
References: <20030912165044.GA14440@vana.vc.cvut.cz>
 <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com>
 <20030916232318.A1699@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Andries Brouwer wrote:

> In Petr's case it looks like his switch produces a single well-defined
> byte (0x41) when switching. What about you? Do you get garbage at the
> moment of switching, or always the same code(s)?
> Do you only get the spurious repeat when switching?
> Andrew gets spurious repeats together with mouse activity. Do you?
> 
> I am especially interested in cases where people can reproduce
> an unwanted key repeat. The question is: is this a bug in our timer code
> or use of timers, or did the keyboard never send the key release code?
> 
> (#define DEBUG in i8042.c)

Hi Andries, sorry for not following up. i'll enable and test this 
immediately, my case is a bit hard to reproduce (a matter of days) but if 
you'd like to see a capture from KVM switching i can do that.

Follow up coming shortly...
