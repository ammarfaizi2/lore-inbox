Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276416AbRJCPmn>; Wed, 3 Oct 2001 11:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276411AbRJCPme>; Wed, 3 Oct 2001 11:42:34 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:22710 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S276418AbRJCPm0>;
	Wed, 3 Oct 2001 11:42:26 -0400
Message-ID: <3BBB31F4.C223E12E@candelatech.com>
Date: Wed, 03 Oct 2001 08:42:44 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110030850480.4495-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

> No. NAPI is for any type of network activities not just for routers or
> sniffers. It works just fine with servers. What do you see in there that
> will make it not work with servers?

Will NAPI patch, as it sits today, fix all IRQ lockup problems for
all drivers (as Ingo's patch claims to do), or will it just fix
drivers (eepro, tulip) that have been integrated with it?

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
