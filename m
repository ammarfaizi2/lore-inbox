Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTBGNYl>; Fri, 7 Feb 2003 08:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTBGNYl>; Fri, 7 Feb 2003 08:24:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1443
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264936AbTBGNYl>; Fri, 7 Feb 2003 08:24:41 -0500
Subject: Re: two x86_64 fixes for 2.4.21-pre3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, jt@hpl.hp.com,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <20030207105818.GB750@elf.ucw.cz>
References: <15921.37163.139583.74988@harpo.it.uu.se>
	 <20030124193721.GA24876@wotan.suse.de>
	 <15926.60767.451098.218188@harpo.it.uu.se>
	 <20030128212753.GA29191@wotan.suse.de>
	 <15927.62893.336010.363817@harpo.it.uu.se>
	 <20030129162824.GA4773@wotan.suse.de>
	 <15934.49235.619101.789799@harpo.it.uu.se>
	 <20030203194923.GA27997@bougret.hpl.hp.com>
	 <20030203201255.GA32689@wotan.suse.de>  <20030207105818.GB750@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044628339.14350.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Feb 2003 14:32:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 10:58, Pavel Machek wrote:
> > That is currently done (-EINVAL), but the emulation layer logs an 
> > warning.
> 
> Perhaps we need new error code -EEMULATION with message "not supported
> within this emulation"?

-ENOSYS is the normal return for an unknown syscall. -ENOTTY for an
invalid ioctl (-EINVAL I think is wrong ?)

Alan

