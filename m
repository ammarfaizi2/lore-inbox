Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTFZVBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFZVB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:01:26 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:31963 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262593AbTFZVBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:01:22 -0400
Date: Thu, 26 Jun 2003 23:15:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brandon Low <lostlogic@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7[123] PS/2 issues (synaptics mouse and laptop keyboard)
Message-ID: <20030626231532.D5633@ucw.cz>
References: <20030624164623.GL30282@lostlogicx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030624164623.GL30282@lostlogicx.com>; from lostlogic@gentoo.org on Tue, Jun 24, 2003 at 11:46:23AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 11:46:23AM -0500, Brandon Low wrote:
> Afternoon kernel-gurus :)
> 
> Every 2.5 kernel since 2.5.70-mm9 that I have tried to use has failed to
> work properly.  
> The primary issue is as mentioned elsewhere that the synaptics touchpad
> simply doesn't work when psmouse is loaded.  The psmouse_noext option
> results in behaviour worse than the old default where no tap-to-click
> works at all.  
> 
> However, there are other issues with the new ps/2 code, the keyboard
> appears to get interrupt stormed at sometimes (or something) and I find
> that letters either appear repeated (once for each keystroke after the
> offending letter) or the keyboard response rate drops so low that I have
> to type like a hunt-and-pecker in order to ensure that all of my
> characters are captured.
> 
> I am up for any troubleshooting projects you wish to send me on, but I
> don't know enough about kernel drivers to hunt down these issues in the
> ps/2 code myself.

There is this nice and easy #define DEBUG in
drivers/input/serio/i8042.c. Reproduce the problem and send me the
relevant part of the log. I'll look into it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
