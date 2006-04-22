Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWDVSxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWDVSxr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWDVSxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:53:47 -0400
Received: from styx.suse.cz ([82.119.242.94]:47048 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750925AbWDVSxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:53:46 -0400
Date: Sat, 22 Apr 2006 20:54:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: usbkbd not reporting unknown keys
Message-ID: <20060422185402.GC10613@suse.cz>
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com> <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com> <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com> <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com> <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com> <305c16960603091230r32038a86mbefc6d80bedb24ab@mail.gmail.com> <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com> <305c16960604221111u714bd3b1h2aeb0559b07d911b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960604221111u714bd3b1h2aeb0559b07d911b@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 03:11:30PM -0300, Matheus Izvekov wrote:

> Hi, i started this thread a long time ago and still got no definitive
> response for it. Whats the position of you guys? Is it an issue worth
> a fix in mainline at all?

My opinion is that usbkbd serves as:

	a) an example usb/input driver
	b) for embedded systems where usbhid is too large

For keyboards with extra keys, use usb-hid.

-- 
Vojtech Pavlik
Director SuSE Labs
