Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVKGRAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVKGRAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVKGRAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:00:54 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:31799 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964906AbVKGRAx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:00:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Iiy8BtrbIq+UtDYvGVWMKvuN5VJETRslB/8M9EYaohVWWOs/LiQN/e+sh7eVloXBFHQvSEeqd1ADhJFDl+S4Y+0yJLBn+uTpXfyfigwXYMS+LX1n1R51d0mGx+jgzbdC/3u8kONswuzoIa9dW8L3tiHmiOqMGBfCXFffSTzChY0=
Date: Mon, 7 Nov 2005 18:00:45 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Toon van der Pas <toon@hout.vanvergehaald.nl>
Cc: rostedt@goodmis.org, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 3D video card recommendations
Message-Id: <20051107180045.ec86a7f2.diegocg@gmail.com>
In-Reply-To: <20051107152009.GA20807@shuttle.vanvergehaald.nl>
References: <1131112605.14381.34.camel@localhost.localdomain>
	<1131349343.2858.11.camel@laptopd505.fenrus.org>
	<1131367371.14381.91.camel@localhost.localdomain>
	<20051107152009.GA20807@shuttle.vanvergehaald.nl>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 7 Nov 2005 16:20:09 +0100,
Toon van der Pas <toon@hout.vanvergehaald.nl> escribió:

> > MS folks would have the same problem.
> 
> ...which proves the point Arjan is making.
> 
> For one, I have an ISDN-adapter which doesn't work with any version of
> MS-Windows from this millennium (no drivers available), while it's still
> working great on current Linux kernels.

agreed, I have the same problems with a creative (a well know vendor)
webcam. Stopped working on SP2.

The problem in windows (and linux closed-sourced drivers) is _much_ bigger
than it seems. Soon all CPUs will be 64-bit capable and dual core, and that
brings two problems: 64-bit-compatible drivers and SMP-safe drivers. I used
to have a cheap winmodem which would deadlock my smp machine. There're lots
of crappy windows drivers which haven't been even tested in a smp machine
it seems. If you buy a dual-core machine and your vendor has gone out of
bussines or the "support period" is expired you migh need to buy new
hardware :(


The 64-bit driver issue is bigger: Even HP has already a (somewhat long)
list of printers which HP is definitively _never_ going to support in 64 bit
platforms (and that's HP, you can imagine what small vendors are doing).
It seems that most of desktop hardware makers are supporting the 64 bit
windows platform just for new devices - unless you had 64 bit in mind when
you created it (which is not possible, because nobody knew what was going to
happen in the 64 bit desktop land until intel supported x86-64) supporting
64 bit may be very well impossible, since they need to port the drivers
of all the thousands of devices they've made through years, and the windows
platform doesn't make it easier (pointers are obviously 64-bit long in the
windows 64 bit platform but longs are still 32 bit for compatibility and
driver programmers don't find it helpful I've heard)

I wish there was opensource drivers for windows. Maybe the fact that some
companies are opening them in linux will make that easier in the future :/
