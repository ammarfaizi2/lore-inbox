Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269731AbTGOVN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269729AbTGOVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:13:26 -0400
Received: from ip45.usw1.rb1.pdx.nwlink.com ([207.202.132.45]:65413 "EHLO
	consumption.net") by vger.kernel.org with ESMTP id S269731AbTGOVNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:13:16 -0400
Date: Tue, 15 Jul 2003 14:28:07 -0700 (PDT)
From: <crozierm@consumption.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse "hang" with 2.5.75
In-Reply-To: <20030715211245.GA5435@kroah.com>
Message-ID: <Pine.LNX.4.21.0307151418520.7513-100000@consumption.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does the same thing happen on 2.4.21?

Nope, never.

> Can you enable CONFIG_USB_DEBUG?

It already is enabled.  When this happens, nothing is printed in the logs
until I unplug the mouse.

> Hm, yeah, this looks like an X issue :)

Should it be possible for X to lock up the mouse?  When the mouse stops
working in X, it seems to stop working for everything else too (the "cat
/dev/input/mice" test, at least).

> 
> Unless by enabling that config option, you get some information
> otherwise...

Is there anything besides this I can do to try and figure out what's going
on?

-michael

