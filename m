Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbTFPVPN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTFPVPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:15:13 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:28426 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264308AbTFPVPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:15:08 -0400
Date: Mon, 16 Jun 2003 22:28:58 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Vojtech Pavlik <vojtech@ucw.cz>
cc: Peter Berg Larsen <pebl@math.ku.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <20030614105552.C12208@ucw.cz>
Message-ID: <Pine.LNX.4.44.0306162228440.26878-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Definitely. Still it doesn't cover the multi-tap/gesture stuff.
> > 
> > How about EV_AREA
> > codes = "which area"  1, 2, 3
> > value = "How big of a area" 
> > 
> > struct input_event {
> >         struct timeval time;
> >         __u16 type;               EV_AREA
> >         __u16 code;	          AREA_1
> >         __s32 value;		  20
> > };
> 
> Nice, but no devices are reporting such detailed info. If you have a
> multi-finger tap, then the area reported is the area between the
> fingers. 

:-(

