Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272332AbTGYVVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272327AbTGYVUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:20:07 -0400
Received: from mailc.telia.com ([194.22.190.4]:63184 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S272332AbTGYVSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:18:38 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: David Benfell <benfell@greybeard95a.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
References: <bXg8.4Wg.1@gated-at.bofh.it>
	<S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org>
	<20030724212416.GA18141@vana.vc.cvut.cz>
	<20030725070806.GB15819@parts-unknown.org>
From: Peter Osterlund <petero2@telia.com>
Date: 25 Jul 2003 23:32:30 +0200
In-Reply-To: <20030725070806.GB15819@parts-unknown.org>
Message-ID: <m2ispq47ip.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Benfell <benfell@greybeard95a.com> writes:

> First someone pointed me at the driver available through
> 
> http://w1.894.telia.com/~u89404340/touchpad/index.html
> 
> I hadn't known about this, but I implemented it.  It does not work
> for me under either the 2.6.0-test1-ac2 kernel or the kernel I was
> using before (2.4.21-pre6).
> 
> Output from the startx is:
> 
> auto-dev: Found Synaptics in /proc/bus/input/devices
> auto-dev: Found its handler entry
> auto-dev: cannot find the event-device in the handlers-entry for the Synaptics touchpad hardware. Falling back to psaux protocol and the Device Option from XF86Config.
> Query no Synaptics: 6003C8

It looks like the problem is that the evdev module is not loaded.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
