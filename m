Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267710AbTBGBag>; Thu, 6 Feb 2003 20:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267711AbTBGBag>; Thu, 6 Feb 2003 20:30:36 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:65259 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267710AbTBGBag>;
	Thu, 6 Feb 2003 20:30:36 -0500
Date: Thu, 6 Feb 2003 16:36:35 -0800
To: David Gibson <david@gibson.dropbear.id.au>, jt@hpl.hp.com,
       Jouni Malinen <jkmaline@cc.hut.fi>, joshk@triplehelix.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 kernel + hostap_cs + X11 = scheduling while atomic
Message-ID: <20030207003635.GA20348@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030205073637.GA10725@saltbox.argot.org> <20030206052849.GA1540@jm.kir.nu> <20030206172759.GC17785@bougret.hpl.hp.com> <20030207000733.GD4905@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030207000733.GD4905@zax>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 11:07:33AM +1100, David Gibson wrote:
> > 
> > 	I had an argument with David a few month ago on the subject
> > (you can ask him how it ended). I believe that it's not a good
> > practice to "schedule" in any of the ioctl, and that seem to also
> > apply to get_wireless_stats. On the other hand, you can perfectly take
> > a spinlock, disable irq and do your job.
> 
> Yes, this is because most of the device ioctl() calls are made with
> one or more spinlocks held by the network layer.
> 
> -- 
> David Gibson

	Thanks for the clarification, appreciated...

	Jean

