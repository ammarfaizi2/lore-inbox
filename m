Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbTFMWlq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265571AbTFMWlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:41:46 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:49867 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265567AbTFMWlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:41:45 -0400
Date: Sat, 14 Jun 2003 00:55:32 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Peter Osterlund <petero2@telia.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <20030614000810.A10851@ucw.cz>
Message-ID: <Pine.LNX.4.40.0306140028350.27605-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 14 Jun 2003, Vojtech Pavlik wrote:

> > What do we call these things? ABS_FINGER_WIDTH and ABS_NR_FINGERS
> > maybe?

> Could work. Or as James Simmons suggested ABS_AREA.

ABS_NR_FINGERS and ABS_AREA ? I find ABS_FINGER_WIDTH to more telling.

The important part is that the driver must know when there is added or
removed a finger as touchpads sends the avarage positions of the fingers.
Adding or removing a finger moves the mouse if the driver does nothing.

There are other questions, if the API is to be used by a general user
touchpad driver. Is there a way to communicate the resolution of the x,y
and z coordinates to the user driver? (not only min/max). How do I tell
that the y coordinate is reversed (gliderpointer) ?


Peter






