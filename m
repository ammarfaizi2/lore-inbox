Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSIIMx7>; Mon, 9 Sep 2002 08:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSIIMx6>; Mon, 9 Sep 2002 08:53:58 -0400
Received: from users.linvision.com ([62.58.92.114]:10127 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S317282AbSIIMx6>; Mon, 9 Sep 2002 08:53:58 -0400
Date: Mon, 9 Sep 2002 14:58:29 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Weber <john.weber@linux.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux on Toshiba Libretto 70CT
Message-ID: <20020909145828.A30633@bitwizard.nl>
References: <3D7563B2.2090707@linux.org> <1031138132.2796.24.camel@irongate.swansea.linux.org.uk> <3D777BC0.9030004@linux.org> <1031240975.6623.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031240975.6623.10.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 04:49:35PM +0100, Alan Cox wrote:
> > Disabling the accelerated functions also "fixes" the machine, for some 
> > definitions of "fix" :).
> 
> That sounds like an X bug then
> 
> > My question is really why this problem would lock up the kernel...
> > I can't really tell whether the problem is in the implementation of the 
> > XFree86 functions or the kernel functions it is calling, but the fact 
> > that the entire kernel locks up suggests that both are to blame.  Can 
> > you suggest where I should start reading code (if not the file atleast 
> > the directory :).
> 
> X maps the video hardware and drives it directly. In that sense X is the
> device driver for video not the kernel.

... And some chips have bugs like "will hang the PCI bus if you
disable this while the chip is doing that". The chip "errata" will
read "don't do that then", and the manufacturer will try to make the
windows driver "not do that". But the Xfree driver may be lagging and
still do this occasionally.

			Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
