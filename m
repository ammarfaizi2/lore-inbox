Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbUAJSwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUAJSwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:52:23 -0500
Received: from zork.zork.net ([64.81.246.102]:45444 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265292AbUAJSwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:52:21 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, vojtech@suse.cz
Subject: Re: Do not use synaptics extensions by default
References: <20040110175930.GA1749@elf.ucw.cz>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, kernel list
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>, 
 vojtech@suse.cz
Date: Sat, 10 Jan 2004 18:52:15 +0000
In-Reply-To: <20040110175930.GA1749@elf.ucw.cz> (Pavel Machek's message of
 "Sat, 10 Jan 2004 18:59:30 +0100")
Message-ID: <6ubrpb7i1s.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> ..aka "make synaptics touchpad usable in 2.6.1" -- synaptics support
> is not really suitable to be enabled by default. You can not click by
> tapping the touchpad (well, unless you have very new X with right
> configuration, but than you can't go back to 2.4), and touchpad senses
> your finger even when it is not touching, doing spurious movements =>
> you can't hit anything on screen. Without synaptics extensions
> everything works just fine. You can reenable synaptics support using
> commandline.

My laptop has a dodgy trackpoint attached to the passthrough port,
although the touchpad works fine.  Before 2.6.1 this didn't matter,
because whether by accident or design, the passthrough was disabled.
Does this patch disable the passthrough port by default?  If not,
would it be possible to add a boot parameter or something to allow it
to be disabled?

