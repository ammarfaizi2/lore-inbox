Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135471AbRDWPzx>; Mon, 23 Apr 2001 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135483AbRDWPzn>; Mon, 23 Apr 2001 11:55:43 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:58767 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135471AbRDWPz2>; Mon, 23 Apr 2001 11:55:28 -0400
Date: Mon, 23 Apr 2001 11:53:32 -0400
From: Bill Nottingham <notting@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: whitney@math.berkeley.edu, manuel@mclure.org,
        Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: Problem with "su -" and kernels 2.4.3-ac11 and higher
Message-ID: <20010423115332.A27493@devserv.devel.redhat.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	whitney@math.berkeley.edu, manuel@mclure.org,
	Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200104230242.f3N2gns08877@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <E14rcVF-0007cJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14rcVF-0007cJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 23, 2001 at 10:19:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox (alan@lxorguk.ukuu.org.uk) said: 
> > > Did you try nesting more than one "su -"? The first one after a boot
> > > works for me - every other one fails.
> > 
> > Same here: the first "su -" works OK, but a second nested one hangs:
> 
> It appears to be a bug in PAM. Someone seems to reply on parent/child running
> order and just got caught out

I'm not so sure; this hang is already after all the authentication is
done.

Bill
