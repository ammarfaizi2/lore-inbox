Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291779AbSBAOzd>; Fri, 1 Feb 2002 09:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291778AbSBAOzV>; Fri, 1 Feb 2002 09:55:21 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:41375 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291776AbSBAOzN>;
	Fri, 1 Feb 2002 09:55:13 -0500
Date: Fri, 1 Feb 2002 09:55:10 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, kaos@ocs.com.au, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020201095510.D17412@havoc.gtf.org>
In-Reply-To: <20020131.222643.85689058.davem@redhat.com> <E16WfDe-0005Jd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16WfDe-0005Jd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 01, 2002 at 03:03:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 03:03:13PM +0000, Alan Cox wrote:
> > If you have a dependency concern, you put yourself in the
> > right initcall group.  You don't depend ever on the order within the
> > group, thats the whole idea.  You can't depend on that, so you must
> > group things correctly.
> 
> This was proposed right back at the start. Linus point blank vetoed it.

My ideal would be to express dependencies in driver.conf (when that is
implemented), and that will in turn affect the link order by
autogenerating part of vmlinux.lds.  Until then, initcall groups are
fine with me...

	Jeff



