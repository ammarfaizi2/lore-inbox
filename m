Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263641AbTCUPr1>; Fri, 21 Mar 2003 10:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263642AbTCUPr1>; Fri, 21 Mar 2003 10:47:27 -0500
Received: from mail.pharm.uu.nl ([131.211.16.17]:8444 "HELO mail.pharm.uu.nl")
	by vger.kernel.org with SMTP id <S263641AbTCUPr0>;
	Fri, 21 Mar 2003 10:47:26 -0500
Subject: i2c_inc/dec_use_client in 2.5.x?
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048262264.11545.52.camel@ph58212.pharm.uu.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Mar 2003 16:57:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

what happened to above-mentioned functions? Well, yes, I can see that
they're removed in 2.5.65 (probably earlier, I can't find them in any
2.5.x version), but why? Aren't the i2c client modules supposed to keep
their use count dynamically anymore? i2c_client->inc/dec_use are gone
too...

I had a short look at the saa7111 file (drivers/media/video/saa7111.c),
and it seems to keep use count in the attach/detach callbacks. Is this
the way to go? In the documentation (probably from 2.4.x), developers
were told this was stupid (Documentation/i2c/writing-clients). What's
the current 'policy'?

Thanks,

Ronald
(please CC, I'm not subscribed)

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

