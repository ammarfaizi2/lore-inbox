Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTIYOQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 10:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbTIYOQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 10:16:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:37331 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261226AbTIYOQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 10:16:53 -0400
Date: Thu, 25 Sep 2003 16:12:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>,
       Adrian Bunk <bunk@fs.tum.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: PS2 keyboard & mice mandatory again ?
Message-ID: <20030925141226.GA25505@ucw.cz>
References: <1064428364.1673.11.camel@rousalka.dyndns.org> <20030925074656.GA22543@ucw.cz> <1064477341.13077.7.camel@ulysse.olympe.o2t> <20030925111547.GL15696@fs.tum.de> <1064491863.17990.10.camel@ulysse.olympe.o2t> <3F72F1F6.1040007@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F72F1F6.1040007@longlandclan.hopto.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:47:34PM +1000, Stuart Longland wrote:

> I presonally would like to be able to choose if I want to use the PS/2
> driver or not.  Mainly because a couple of machines I have here, use the
> old AT keyboard (DIN-5 connection, not PS/2 or USB), and have <128MB
> RAM.  For instance, how many 386 computers have you seen with at least
> 32MB RAM & PS/2 or USB sockets? [1]

Surprisingly enough, there is no difference between DIN-5 (aka Extended
AT) and MiniDIN-6 (aka PS/2) keyboards except for the connector shape.

So you'll need the driver even on your i386's. You can drop the mouse
driver there, though.

> (And yes, I probably would be crazy enough to go put Linux 2.6 on to a
> 386, I've considered installing Gentoo on one actually -- just to see
> how long it takes :-D)
> 
> Footnotes:
> 1. I've only seen one exception to this, that is one old (also dead)
> Olivetti 386 laptop which had PS/2 keyboard & mouse sockets.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
