Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263341AbTIGPoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbTIGPoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:44:17 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:26128 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263341AbTIGPoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:44:16 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: azarah@gentoo.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6] Fix conversion from milli volts in store_in_reg() for w83781d.c
Date: Sun, 7 Sep 2003 19:41:29 +0400
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
References: <3ED8067E.1050503@paradyne.com> <20030616184149.GC25585@kroah.com> <1062622452.5275.38.camel@nosferatu.lan>
In-Reply-To: <1062622452.5275.38.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309071941.30338.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 00:54, Martin Schlemmer wrote:
[...]
> nosferatu patch # echo '3700' > /sys/bus/i2c/devices/1-0290/in_max2
> nosferatu patch # cat /sys/bus/i2c/devices/1-0290/in_max2
> 400
[...]
> I think Andrey also noticed this (if I did not smoke too much Weedbix
> this morning ;) - if so, please verify that this fixes it ... it does
> here at least.
>

yes, it has fixed it. thank you

-andrey
