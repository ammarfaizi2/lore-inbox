Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271206AbTHLXG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 19:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271210AbTHLXG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 19:06:29 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:26638 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271206AbTHLXG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 19:06:28 -0400
Date: Wed, 13 Aug 2003 01:06:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Pete Zaitcev <zaitcev@redhat.com>,
       Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: i8042 problem
Message-ID: <20030813010626.A1877@pclin040.win.tue.nl>
References: <20030726093619.GA973@win.tue.nl> <20030726212513.A0BD.CHRIS@heathens.co.nz> <20030727020621.A11637@devserv.devel.redhat.com> <20030727104726.GA1313@win.tue.nl> <20030812204246.GA23011@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030812204246.GA23011@ucw.cz>; from vojtech@suse.cz on Tue, Aug 12, 2003 at 10:42:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 10:42:46PM +0200, Vojtech Pavlik wrote:

> > -         int timeout = 10000; /* 100 msec */
> > +         int timeout = 100000; /* 100 msec */
> 
> Note that we do udelay(10) in the loop,

Right.
Pete Zaitcev made it 20000 (since he needed 11000).
That seems reasonable.

