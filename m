Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTCEPdf>; Wed, 5 Mar 2003 10:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTCEPdf>; Wed, 5 Mar 2003 10:33:35 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:19605 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267180AbTCEPde>; Wed, 5 Mar 2003 10:33:34 -0500
Message-Id: <200303051543.h25FhgGi006507@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Wed, 05 Mar 2003 07:12:45 PST."
             <20030305.071245.92277670.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 05 Mar 2003 10:43:42 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030305.071245.92277670.davem@redhat.com>,"David S. Miller" writes
:
>As ATM maintainer, now might be a good time to learn this :-)

i have a religious objection to clip.  ask me about lane :)  seriously
though i know there are a coulple problems with the clip driver:  xoff
handling is really quite 'strange' and there appears to a race with the
neighbor table handling w/ svcs.  i really just want to get things running
again (however poorly) on 2.5 before 'fixing' things.
