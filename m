Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271124AbRIFPL5>; Thu, 6 Sep 2001 11:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271212AbRIFPLi>; Thu, 6 Sep 2001 11:11:38 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:63494 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271124AbRIFPLe>;
	Thu, 6 Sep 2001 11:11:34 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109061511.TAA10532@ms2.inr.ac.ru>
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
To: hadi@cyberus.ca (jamal)
Date: Thu, 6 Sep 2001 19:11:40 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, ak@muc.de
In-Reply-To: <Pine.GSO.4.30.0109051803500.11700-100000@shell.cyberus.ca> from "jamal" at Sep 5, 1 06:08:18 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Whats wrong with this patch (just a thought, not tested or even compiled)?

Wrong is that it stops to work if you do not fill ifr_data.
This field in write only in 4.3BSD and in Linux.

Alexey
