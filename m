Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRCCX2x>; Sat, 3 Mar 2001 18:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRCCX2o>; Sat, 3 Mar 2001 18:28:44 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:41514 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129854AbRCCX2b>; Sat, 3 Mar 2001 18:28:31 -0500
Date: Sat, 3 Mar 2001 17:28:22 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Francis Galiegue <fg@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com, Kernel list <kernel@linux-mandrake.com>
Subject: Re: [kernel] Re: [PATCH] 2.4.2: cure the kapm-idled taking (100-epsilon)% CPU time
Message-ID: <20010303172822.A18970@mandrakesoft.mandrakesoft.com>
In-Reply-To: <E14ZLG0-0004I5-00@the-village.bc.nu> <Pine.LNX.4.21.0103040016050.922-100000@toy.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.21.0103040016050.922-100000@toy.mandrakesoft.com>; from Francis Galiegue on Sun, Mar 04, 2001 at 12:19:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2001 at 12:19:07AM +0100, Francis Galiegue wrote:
> Well, from reading the source, I don't see how this can break APM... What am I
> missing?

apm_bios_call must not be called with two identical pointers for
two different registers.
