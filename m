Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265513AbUBPNZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUBPNZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:25:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42195 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265513AbUBPNZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:25:28 -0500
Date: Mon, 16 Feb 2004 12:52:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jurriaan on adsl-gate <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Keyboard on ... reports too many keys pressed
Message-ID: <20040216115221.GC470@openzaurus.ucw.cz>
References: <20040207064027.GA20495@gates.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207064027.GA20495@gates.of.nowhere>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On my laptop, I get a lot of
> 
> Keyboard on ... reports too many keys pressed.
> 
> That may well be the case, I use my normal hands on a small
> laptop-keyboard.
> Why is that message printed? There nothing I can do about pressing
> multiple keys by accident, so I don't think it's useful.
> 
> It does, however, frequently mess up the commandline, which leads to big
> frustration.
> 
> Couldn't this be wrapped in #ifdef ATKBD_DEBUG or something? Is it
> really necessary to see this message?

Its error condition -- keyboard lost track of keys -- and
yes thats worth a printk. Try running klogd.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

