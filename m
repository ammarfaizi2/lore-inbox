Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271510AbTGQQyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271508AbTGQQyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:54:49 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:11449 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S271510AbTGQQxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:53:52 -0400
Date: Thu, 17 Jul 2003 18:08:11 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030717170811.GC4280@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Vojtech Pavlik <vojtech@suse.cz>, Jens Axboe <axboe@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk> <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de> <20030716190018.GE20241@ucw.cz> <20030716193002.GA2900@suse.de> <20030716205319.GA20760@ucw.cz> <20030716233124.GA16209@suse.de> <20030716234711.GA22010@ucw.cz> <1058440490.8620.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058440490.8620.18.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 12:15:04PM +0100, Alan Cox wrote:
 > Dave just a random pondering looking over the code - does it make any
 > difference if you stick a udelay(50) at the top of wait_read and
 > wait_write in i8042.c. Right now we don't always seem to honour the
 > delays for certain specific patterns of I/O and interrupt.
 > 
 > Ditto the read_status/read_data loop in the _interrupt code path.

No joy.

		Dave

