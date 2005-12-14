Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVLNAPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVLNAPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 19:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVLNAPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 19:15:13 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:63707 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030267AbVLNAPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 19:15:11 -0500
Date: Tue, 13 Dec 2005 19:57:29 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: torvalds@osdl.org, akpm@osdl.org, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Giving the reins over to Dmitry
Message-ID: <20051213195729.A7513@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051213084111.GA20748@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Vojtech Pavlik <vojtech@ucw.cz> wrote:
>
>>   INPUT (KEYBOARD, MOUSE, JOYSTICK) DRIVERS
>>  -P:	Vojtech Pavlik
>>  -M:	vojtech@suse.cz
>>  +P:	Dmitry Torokhov
>>  +M:	dtor_core@ameritech.net
>
> I guess this means that I should drop http://www.ucw.cz/~vojtech/input/
> from the -mm lineup?

Some of those look pretty good, hopefully Dmitry will pick them up?
Specifically...

    hid-variable-max-buffer-size.diff 
    hiddev-sync-after-report-write.diff 
    hid-no-unplug-on-success.diff

...are interesting to me.

--Adam

