Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131680AbRCURMf>; Wed, 21 Mar 2001 12:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131690AbRCURM0>; Wed, 21 Mar 2001 12:12:26 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55170 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131680AbRCURMK>;
	Wed, 21 Mar 2001 12:12:10 -0500
Message-ID: <3AB8E0A1.43C61083@mandrakesoft.com>
Date: Wed, 21 Mar 2001 12:10:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, khc@pm.waw.pl,
        Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] Re: [PATCH] Re: [PATCH] 2.4.3-pre6 - hdlc/dscc4 missing bits
In-Reply-To: <20010321163031.A28981@se1.cogenit.fr> <3AB8CDE0.2B2619AF@mandrakesoft.com> <20010321173930.A29474@se1.cogenit.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> 
> Jeff Garzik <jgarzik@mandrakesoft.com> écrit :
> > You should use this patch instead, from Alan's tree, for updating
> > include/linux/if_arp.h...
> 
> It adds confusion: do you imagine the poor soul who discovers hdlc in Linux
> and sees ARPHRD_CISCO and ARPHRD_HDLC for the same use after some hours
> of code-greping (both will be used at the moment if hdlc.c do so) ?
> Don't be surprised if he ends using label pointers everywhere. :o)
> 
> What about the following (2.5 ?):

That looks like 2.5 material to me.  Personally I wouldn't want to
remove identifiers during 2.4 stable series..  Changing all 2.4 code to
use one identifier or the other seems reasonable.

Make sure to sync with Alan.  WAN stuff has been occurring in his tree,
and we want to make sure everybody's on the same page..

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
