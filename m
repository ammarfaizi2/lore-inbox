Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136199AbRDVQ0H>; Sun, 22 Apr 2001 12:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136200AbRDVQZ5>; Sun, 22 Apr 2001 12:25:57 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:38923 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S136199AbRDVQZt>; Sun, 22 Apr 2001 12:25:49 -0400
Message-ID: <3AE30609.21692820@damncats.org>
Date: Sun, 22 Apr 2001 12:25:45 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rA0N-0004sv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 2.4.3-ac12
> o       Further semaphore fixes                         (David Howells)

Getting unresolved symbols in some modules (notably, for me, microcode.o
and radeon.o)...

Using /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o
/lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o: unresolved
symbol rwsem_up_write_wake
/lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o: unresolved
symbol rwsem_down_write_failed

John
