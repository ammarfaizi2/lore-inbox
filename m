Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131196AbRCGVYq>; Wed, 7 Mar 2001 16:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbRCGVYg>; Wed, 7 Mar 2001 16:24:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21645 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131196AbRCGVYX>;
	Wed, 7 Mar 2001 16:24:23 -0500
Message-ID: <3AA6A6D6.70877AA3@mandrakesoft.com>
Date: Wed, 07 Mar 2001 16:23:34 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
        "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com
Subject: Re: [PATCH] RFC: fix ethernet device initialization
In-Reply-To: <3AA6A570.57FF2D36@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, it should be noted that since this is intended as a stable 2.4
series change.  The patch does not change any existing APIs, only adds a
function.  Existing 2.4 drivers are free to continue using
init_etherdev...  This bug, which I fix, isn't causing oops AFAIK, just
exporting ugliness to user space etc.
-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
