Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262467AbSJLAJn>; Fri, 11 Oct 2002 20:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262468AbSJLAJn>; Fri, 11 Oct 2002 20:09:43 -0400
Received: from relaydude.reardensteel.com ([64.160.169.119]:14084 "HELO
	relaydude.reardensteel.com") by vger.kernel.org with SMTP
	id <S262467AbSJLAJm>; Fri, 11 Oct 2002 20:09:42 -0400
Subject: Re: 2.5.41 Autofs4: bad: scheduling while atomic!
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Sylvain Pasche <sylvain_pasche@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15783.5936.803024.183802@yahoo.fr>
References: <15781.46151.531066.683163@yahoo.fr>
	<1034322155.1568.14.camel@ezr>  <15783.5936.803024.183802@yahoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Oct 2002 17:13:51 -0700
Message-Id: <1034381631.1319.2.camel@sherkaner.pao.digeo.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-11 at 11:23, Sylvain Pasche wrote:
    Unfortunately, I did not keep the .config.
    
    From what I remember, I had CONFIG_PREEMPT set and CONFIG_SMP not set.
    
    I'm not under 2.5 now, but I can recompile and test again if you want
    to be able to reproduce it and have more details..

I really can't see how it could get into a non-preemptable state along
that path. Did anything else bad happen in that session?  Any oopses or
other funnies?  Can you give more detail about what you were doing at
the time?  Was it the first use of autofs, or had you been using it
heavily?  How many autofs filesystems mounted?

Thanks,
	J

