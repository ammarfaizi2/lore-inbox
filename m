Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWGXQiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWGXQiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWGXQiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:38:25 -0400
Received: from mail1.cenara.com ([193.111.152.3]:52420 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S932206AbWGXQiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:38:24 -0400
From: Magnus =?utf-8?q?Vigerl=C3=B6f?= <wigge@bigfoot.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Date: Mon, 24 Jul 2006 18:28:32 +0200
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060721211341.5366.93270.sendpatchset@pipe> <200607221200.51700.wigge@bigfoot.com> <200607230124.56094.dtor@insightbb.com>
In-Reply-To: <200607230124.56094.dtor@insightbb.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200607241828.32356.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 07:24, Dmitry Torokhov wrote:
[...]
> No, I was not talking about FUSD, just uinput driver that is in kernel
> proper. Take a look at this:
>
> 	http://svn.navi.cx/misc/trunk/inputpipe/
>
> It allows making input devices "network-transparent" and for example
> use joystick physically connected to one box to play game on another.
> Hmm, actually it is almost what you need, you just need modify server
> to multiplex events into single device instead of creating separate
> input devices.

Interesting.. This might be handy for other projects. However, implementing 
the same module again, but in userspace, for something that really should be 
handled in the X-server (and will in time), nah.. I think I'll see what the 
X-guys are up to and see how long they've come instead. Maybe I can contribute 
there in some way.

> > So.. Are the locking issues in evdev something that is about to be fixed
> > soon or should I contribute? Or do you think the issue will be completely
> > irrelevant for a user-space driver?
>
> No, I think you will still have the same issues with locking, unfortunately
> I can't commint on a specific date when they will be resolved. Patches are
> always welcome of course.

Just wanted to know if you had something ongoing regarding this.. I'll see 
what I can come up with.

 /Magnus
