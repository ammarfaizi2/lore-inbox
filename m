Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRKKKER>; Sun, 11 Nov 2001 05:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278177AbRKKKD6>; Sun, 11 Nov 2001 05:03:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:45818
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277612AbRKKKDy>; Sun, 11 Nov 2001 05:03:54 -0500
Date: Sun, 11 Nov 2001 02:03:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error message during modules_install of 2.4.14
Message-ID: <20011111020347.B19916@mikef-linux.matchmail.com>
Mail-Followup-To: Peter Klotz <peter.klotz@aon.at>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01111110010300.23755@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01111110010300.23755@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 10:01:03AM +0100, Peter Klotz wrote:
> Hi developers
> 
> During "make modules_install" I got the following error message:
> 
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.14; fi
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.14/kernel/drivers/block/loop.o
> depmod:         deactivate_page
> 
> Is this something to worry about?
> 

Your message is number 54, and I'm making number 55 on this subject...

Look in the lkml archives for the patch that will fix this "2.4.14" and
"loop" should do...

This problem is fixed in 2.4.15pre1, but don't use pre1 or 2 if you use
iptables...

Mike
