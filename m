Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277352AbRJJSbz>; Wed, 10 Oct 2001 14:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277358AbRJJSbq>; Wed, 10 Oct 2001 14:31:46 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:34065 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277359AbRJJSbe>;
	Wed, 10 Oct 2001 14:31:34 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110101831.WAA05257@ms2.inr.ac.ru>
Subject: Re: [PATCH] Trivial patch for SIOCGIFCOUNT
To: balbir.singh@wipro.COM (BALBIR SINGH)
Date: Wed, 10 Oct 2001 22:31:44 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BC3DE5D.8000500@wipro.com> from "BALBIR SINGH" at Oct 10, 1 09:45:02 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> application from Sun, HP-UX or AIX would just do
> 
> #define SIOCGIFNUM SIOCGIFCOUNT

Grrr.... Listen what the hell did you call this ioctl with _another_ name,
absent both in BSD and in SVR4??? :-)

I remember the patch doing the same thing and I zapped this crap
exactly because it was another linuxish hack moving from bsd api
and not moving closer to svr4.

Alexey

PS. Well, and did you think about one thing: "linux" port of any application
which does not work with linuxes can smell a bit anti-social for many people,
who do not compile from sources. And for all the people, if the port is binary.
