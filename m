Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTFWO5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 10:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTFWO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 10:57:45 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:35735 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263638AbTFWO5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 10:57:44 -0400
Date: Mon, 23 Jun 2003 17:11:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Weber <weber@sixbit.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 Mouse
Message-ID: <20030623171136.A21216@ucw.cz>
References: <3EF7010C.5090000@sixbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EF7010C.5090000@sixbit.org>; from weber@sixbit.org on Mon, Jun 23, 2003 at 09:30:52AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 09:30:52AM -0400, John Weber wrote:

> My mouse suddenly stopped working with 2.5.73.  I am using a Synaptics 
> Touchpad --
> with comes with a Dell laptop.  (I will test with an external mouse later).
> 
> The SERIO I8042 driver seems to find my mouse, interrupts are firing, 
> and I enabled
> the old /dev/psaux so that userland doesn't see anything different. 
> Most importantly,
> the same config worked with 2.5.72.  I noticed that dmesg was slightly 
> different across
> the two versions which suggests that something did change.

Option 1)
	Use psmouse_noext option on the command line. This will
	restore the previous behavior easily and immediately.

Option 2)
	Get the Synaptics XFree86 driver for 2.5 kernels from
	http://w1.894.telia.com/~u89404340/touchpad/index.html
	This will enable additional features with the pad, like
	palm detection, multitap gestures and more. It will also
	make the pad work, of course.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
