Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbUJZSPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUJZSPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUJZSMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:12:13 -0400
Received: from sd291.sivit.org ([194.146.225.122]:15260 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261450AbUJZSFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:05:17 -0400
Date: Tue, 26 Oct 2004 20:09:32 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041026180932.GA17655@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
References: <20041026155639.42445.qmail@web81306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026155639.42445.qmail@web81306.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 08:56:39AM -0700, Dmitry Torokhov wrote:

> If you want jogdial to continue generating BTN_MIDDLE and BTN_WHEEL
> events then IMHO you should create 2 separate input devices - one
> for jogdial and the other for FN-keys.

That's what I thought too...

> On the other hand I am not sure if it is handy as a ponter device -
> I think scrolling is much more natural with the touchpad (but
> remember I don't have the hardware)

I don't have a touchpad, just a stick. And I use the jogdial to
scroll quite often...

> and it may be more convenient
> to assign brand-new events to jogdial as well and then map it in
> userspace (X) into something different, like volume control. In
> this case you can continue having just one input device.
> 
> Btw, you should probably drop conditional support for input layer
> and always compile it in.

Is CONFIG_INPUT now a requirement for the (at least i386) kernel ?
If this is the case, I'll drop the conditional. 

Stelian.
-- 
Stelian Pop <stelian@popies.net>
