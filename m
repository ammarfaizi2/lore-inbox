Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRCUOfL>; Wed, 21 Mar 2001 09:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131500AbRCUOfB>; Wed, 21 Mar 2001 09:35:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15332 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131480AbRCUOe7>;
	Wed, 21 Mar 2001 09:34:59 -0500
Message-ID: <3AB8BBC5.61A7F65F@mandrakesoft.com>
Date: Wed, 21 Mar 2001 09:33:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH 2.4.3.6: fix netdevice initialization
In-Reply-To: <3AB8BA16.A25C0929@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this bad habit of thinking of things after I click <Send>.

One other change that accompanies this -- define a feature macro.  The
following should go into linux/netdevice.h:
	#define HAVE_ALLOC_NETDEV

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
