Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSCOK7x>; Fri, 15 Mar 2002 05:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSCOK6R>; Fri, 15 Mar 2002 05:58:17 -0500
Received: from [195.39.17.254] ([195.39.17.254]:10114 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S290120AbSCOK6B>;
	Fri, 15 Mar 2002 05:58:01 -0500
Date: Thu, 14 Mar 2002 14:13:42 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Olivier Galibert <galibert@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020314141342.B37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203111829550.1153-100000@home.transmeta.com> <3C8D69E3.3080908@mandrakesoft.com> <20020311223439.A2434@zalem.nrockv01.md.comcast.net> <3C8D8061.4030503@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C8D8061.4030503@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 11, 2002 at 11:13:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Under more restricted domains, root cannot bit-bang the interface. 
>  s/CAP_SYS_RAWIO/CAP_DEVICE_CMD/ for the raw cmd ioctl interface.  Have 

Nobody uses capabilities these days, right?

> The filter is useful for other reasons like correctness, as well.

If you want to test if it works, you just disallow that access altogether.
It is usually not needed , anyway.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

