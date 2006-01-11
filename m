Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWAKSeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWAKSeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWAKSeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:34:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3522 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932450AbWAKSeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:34:09 -0500
Date: Wed, 11 Jan 2006 19:34:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
In-Reply-To: <43C502AA.1040200@gmail.com>
Message-ID: <Pine.LNX.4.61.0601111933440.19259@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
 <43C4F8EE.10201@gmail.com> <200601111331.45940.ak@suse.de> <43C502AA.1040200@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> With the framebuffer console, you can increase the size of the scrollback
>>> buffer with the boot option:
>>>
>>> fbcon=scrollback:<n> (default is 32K)
>> 
>> On x86-64 vesafb is unusable slow because it does CPU scrolling cause
>> it can't use the vesa BIOS - and the others don't work everywhere. So I don't
>> think fbcon is an usable replacement.
>
>How about vga16fb + fbcon? If scrolling is slow in vga16fb, fbset -vyres 800 should
>increase performance significantly.
>

Benchmarks first.


Jan Engelhardt
-- 
