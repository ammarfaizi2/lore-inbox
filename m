Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271459AbTGQPCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271488AbTGQPCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:02:32 -0400
Received: from mailc.telia.com ([194.22.190.4]:31466 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S271459AbTGQPCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:02:30 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: dongili@supereva.it
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: swsusp + synaptics + usb: 2 issues 1 workaround
References: <20030716211421.GA29335@inferi.kami.home>
From: Peter Osterlund <petero2@telia.com>
Date: 17 Jul 2003 17:17:13 +0200
In-Reply-To: <20030716211421.GA29335@inferi.kami.home>
Message-ID: <m2lluxqj2e.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <dongili@supereva.it> writes:

> I'm testing swsusp with the 2.6.0-test1 kernel. I'm experiencing
> problems when suspending (S4) with usb modules loaded (still hve to
> narow down which one gives problem - ready to help debugging if not a
> known issue).
> 
> the 2 problems are:
> 1. cannot suspend with usb modules loaded (as said) and I have to stop
> hotplug to be able to go S4
> 2. after resuming an X session the synaptics touchpad goes nuts (not
> imeediately anyway)

I have some patches to improve synaptics kernel support. One of the
patches makes the touchpad behave better together with swsusp. The
patches are available here:

        http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test1/v2/

I also see the USB problem, but I think this is already a known issue.

Vojtech, the swsusp patch in the patchset I sent you a few days ago
had some problems, so if you haven't applied those patches yet, I
suggest you apply these new patches instead. Otherwise, I can create
incremental patches for you.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
