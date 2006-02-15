Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422903AbWBOH0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422903AbWBOH0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422990AbWBOH0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:26:21 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:5826 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1422903AbWBOH0V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:26:21 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 15 Feb 2006 08:26:05 +0100
MIME-Version: 1.0
Subject: Re: time patches by Roman Zippel
Cc: linux-kernel@vger.kernel.org
Message-ID: <43F2E59D.24184.A70C2D5@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0602141515500.30994@scrub.home>
References: <43F1F2B4.7205.6BBE301@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.02.0+V=4.02+U=2.07.127+R=06 February 2006+T=118694@20060215.071452Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Feb 2006 at 15:33, Roman Zippel wrote:

[...]
> > Assuming 1024Hz interrupt frequency:
> > (1탎 * 1000) / 1024 == 0ns; 0 * 1024 == 0탎, not 1탎
> > (2탎 * 1000) / 1024 == 1ns; 1 * 1024 == 1.024탎, not 2탎
> 
> Ok, I didn't put much effort into optimizing it for uncommon HZ values. 
> Why is it so important? It's currently unused on any Linux machine 
> synchronized via NTP.

Roman,

how do you know? When using "disable kernel", NTP relies on adjtime() to adjust 
the time. Some people even prefer that, because the algorithms do floating point 
math in user space instead of fixed-point maths in kernel space.

[...]

Regards,
Ulrich

