Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTFDX5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTFDX5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:57:42 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:49307
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S264328AbTFDX5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:57:42 -0400
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Apple Displays and intel platforms
References: <20030604210041$6237@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 04 Jun 2003 17:00:40 -0700
In-Reply-To: <20030604210041$6237@gated-at.bofh.it>
Message-ID: <ugel29mlzr.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 04 Jun 2003 23:00:41 +0200, James Simmons <jsimmons@infradead.org> said:

  James> Has anyone got a framebuffer working on a intel box with a
  James> apple cinerama display?

Yes (if you allow an HP i2000 Itanium system to be counted as an Intel
box, at least).

The display (which isn't mine, unfortunately), came with an Apple
proprietary connector -> DVI/USB convertor, which you'd definitely
need (it contains the power supply for the monitor, for example).
Beyond that, I think you just need a graphics card that can do the
desired resolution (I'm using an ASUS v9180 mx440 card).

I can't control the brightness, as that would apparently require some
Apple-specific USB driver (so much for USB device classes...).
Similarly, to turn off the monitor, I have to use "xset dpms force
off".  Other than that, the display works beautifully.  Love the real
estate it affords... ;-)

	--david
